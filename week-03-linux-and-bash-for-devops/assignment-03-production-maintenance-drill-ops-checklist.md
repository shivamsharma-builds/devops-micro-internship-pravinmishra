# Assignment 3 — Production Maintenance Drill (OPS Checklist)

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will treat your already deployed React application (on Ubuntu VM with Nginx) as a live production system. You will perform structured operational checks covering network validation, service health, log analysis, resource monitoring, configuration verification, and incident simulation with recovery — mirroring real on-call DevOps responsibilities.

---

# Task 1 — Server Access & Networking Validation

## Goal

Verify that the deployed React application is reachable from the browser and confirm basic network connectivity of the Ubuntu VM.

### Evidence

#### Screenshot 1 — Browser showing the React app with your Full Name visible on the UI

![Task 1 Screenshot](screenshots/assignment-02-react-app-build-browser.png)

---

#### Screenshot 2 — Output of `ip a`

![Task 1 Screenshot](screenshots/assignment-03-ip.png)

---

#### Screenshot 3 — Output of `sudo ss -tulpen`

![Task 1 Screenshot](screenshots/assignment-03-tulpen.png)

---

#### Screenshot 4 — Output of `sudo ufw status`

![Task 1 Screenshot](screenshots/assignment-03-status.png)

---

### Notes

Answer the following in your own words:

**1. What proves Nginx is listening on 0.0.0.0:80?**

The ss -tulpen output shows a TCP socket with:

* State: LISTEN
* Local Address:Port: 0.0.0.0:80
* Process:  users:(("nginx",pid=8193,fd=5),("nginx",pid=8192,fd=5),("nginx",pid=8191,fd=5))

This proves Nginx is actively listening on port 80 across all network interfaces (0.0.0.0 = all IPv4 addresses). The process identifiers (pids 29161 and 29160) confirm the Nginx worker processes are bound to this port.

---

**2. What proves SSH is active on port 22?**

The ss -tulpen output shows a TCP socket with:

* State: LISTEN
* Local Address:Port: 0.0.0.0:22
* Process:   users:(("sshd",pid=693,fd=3),("systemd",pid=1,fd=163))

This proves SSH daemon (sshd) is actively listening on port 22 across all network interfaces. The process ID 31810 confirms the SSH service is running and bound to the standard SSH port.

---

**3. Did you find any unexpected open ports? Explain briefly.**

Yes, there are a few ports that may be unexpected depending on your intended server configuration:

* TCP 4096 - Multiple instances associated with "system-resolve" service (systemd-resolved). This is a DNS resolution service and may be expected on a system with networking needs.
* UDP 1323 - Chrony NTP service (Network Time Protocol) for time synchronization. This is typically expected on servers but could be unexpected if you don't need time sync services.

If this server is intended to run only Nginx and SSH, these system services could be considered unexpected. However, they are standard Linux system services and generally harmless. The core expected services (Nginx on 80, SSH on 22) are confirmed and functioning correctly.

---

# Task 2 — Service Health & Systemd Validation (Nginx)

## Goal

Verify that Nginx is properly installed, running, enabled at boot, and safely configured.

### Evidence

#### Screenshot 1 — Output of `systemctl status nginx --no-pager`

![Task 2 Screenshot](screenshots/assignment-03-nginx-status.png)

---

#### Screenshot 2 — Output of `sudo nginx -t`

![Task 2 Screenshot](screenshots/assignment-03-nginx-t.png)

---

#### Screenshot 3 — Output of `sudo ss -lptn '( sport = :80 )'`

![Task 2 Screenshot](screenshots/assignment-03-nginx-port.png)

---

### Notes

Answer the following in your own words:

**1. What happens if Nginx fails to restart in production?**

If Nginx fails to restart in production, several things occur:

* Immediate service disruption: Existing connections are maintained, but the process stops. If the old Nginx process is killed before restart completes, traffic drops immediately until the service recovers.
* Traffic loss: New requests encounter connection timeouts or refused connections. Users see 503 Service Unavailable or connection errors.
* Cascading failures: Upstream services, load balancers, and monitoring systems alert on the outage. Dependent applications that rely on your API/web service fail.
* Operational incident: The incident is logged; escalations trigger; on-call engineers respond. Customer impact is immediate and measurable.
* Root cause uncertainty: The restart failure could indicate syntax errors in nginx.conf, permission issues, port conflicts, missing SSL certificates, or resource exhaustion—all need rapid diagnosis.

The key issue: restart changes are not atomic. If the reload/restart is interrupted or misconfigured, the entire service goes down until recovery.
---

**2. What's your basic rollback plan?**

A basic rollback plan for Nginx includes:

Before deployment:

* Backup the current nginx.conf and any site config files (e.g., /etc/nginx/sites-enabled/)
* Test new config syntax with sudo nginx -t in a staging environment first
* Have the old config file tagged/versioned in version control

During deployment (graceful approach):

* Use sudo nginx -s reload instead of restart (reloads config without killing connections)
* Monitor logs for errors: sudo tail -f /var/log/nginx/error.log
* Check service status: sudo systemctl status nginx

If deployment fails:

1. Stop the failed Nginx process: sudo systemctl stop nginx
2. Restore the previous nginx.conf from backup/version control
3. Verify syntax: sudo nginx -t
4. Restart with known-good config: sudo systemctl start nginx
5. Verify connectivity and logs

For quick rollback (minutes matter):

* Keep a known-good config version immediately accessible
* Run sudo nginx -s reload first for config changes (safer than restart)
* If that fails, restore + restart as fallback
* Alert monitoring systems of the incident

Automation angle: Store nginx.conf in version control (Git), use Infrastructure-as-Code (Terraform/Ansible) to manage deployments, and implement a pre-flight check (syntax test + staging validation) before touching production.

Key principle: Always have a way to get back to the last known-good state within seconds, not hours.

---

# Task 3 — Logs & Request Trace

## Goal

Verify real traffic flow and analyze logs to understand system behavior and errors.

### Evidence

#### Screenshot 1 — Output of `sudo tail -n 30 /var/log/nginx/access.log`

![Task 2 Screenshot](screenshots/assignment-03-nginx-tail.png)

---

#### Screenshot 2 — Output of `sudo tail -n 30 /var/log/nginx/error.log`

![Task 2 Screenshot](screenshots/assignment-03-nginx-tail-error.png)

---

#### Screenshot 3 — Output of `sudo journalctl -u nginx --no-pager -n 50`

![Task 2 Screenshot](screenshots/assignment-03-journal.png)

---

### Notes

Answer the following in your own words:

**1. Were there any errors in the logs?**

- If yes, mention 1–2 example error lines from the logs and explain what each one means in simple terms.
- If no, explain what it means if the error log is empty or shows no recent errors during your check.

No, there were no errors. The error log contains only one line:

`2026/08/12 19:33:46 [notice] 28455#28455: using inherited sockets from "5;6;"`

This is a [notice] level message, not an error. It's informational and means Nginx successfully inherited socket file descriptors (5 and 6) from the systemd service manager during startup. This is normal and expected when Nginx starts via systemctl. A notice is just Nginx reporting routine operational information—not a problem.

---

**2. If there were no errors, what does that indicate about the system?**

An empty/clean error log with no errors, warnings, or critical messages indicates the system is healthy and functioning normally. Specifically:

* Nginx is running without issues—no configuration problems, no crashes, no permission errors
* Requests are being processed successfully without conflicts or resource problems
* No SSL/TLS certificate errors, port binding issues, or worker process failures
* The application is stable and not generating warnings

This is a good sign for production. Your Nginx deployment is operationally sound.

---

**3. Based on the access logs, were your curl requests visible in the log entries? What does that prove about traffic flow?**

No, the curl requests are not visible in the access log. Instead, the logs show real browser traffic from two external IP addresses:

* 83.229.26.237 (accessed on Aug 12 at 19:50:45)
* 187.14.48.90 (accessed on Aug 13 at 21:15:53 and 21:16:52)

The user agents show Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) with Chrome and Safari browsers—these are actual users accessing your React app, not curl requests.

This proves:

* Traffic is flowing correctly from external sources to your Nginx server
* The application is reachable on the public internet (IP 3.144.191.181)
* Static assets are being served (CSS, JavaScript, manifest, favicon) with HTTP 200 responses
* Caching is working (304 Not Modified responses on subsequent requests)
* Your deployment is live and accessible to real users

The absence of curl commands is expected—curl is typically used for local testing or scripted requests, not for logging real user traffic.

---

# Task 4 — System Resource Health Check (Capacity Red Flags)

## Goal

Assess server capacity and detect potential performance or failure risks.

### Evidence

#### Screenshot 1 — Output of `uptime`

Add your screenshot here.

---

#### Screenshot 2 — Output of `free -h`

Add your screenshot here.

---

#### Screenshot 3 — Output of `df -h`

Add your screenshot here.

---

#### Screenshot 4 — Output of `sudo du -sh /var/* | sort -h`

Add your screenshot here.

---

### Notes

Answer the following in your own words:

**1. Which resource looks most critical right now? (CPU/load, memory, or disk) Explain why.**

Write your answer here.

---

**2. What happens if disk becomes 100% full in a production server?**

Write your answer here.

---

# Task 5 — Configuration & Deployment Verification

## Goal

Ensure the correct React build is deployed and Nginx is serving it properly.

### Evidence

#### Screenshot 1 — Output of `ls -lah /var/www/html | head -n 20`

Add your screenshot here.

---

#### Screenshot 2 — Output of `grep -R "Deployed by" -n /var/www/html 2>/dev/null | head`

Add your screenshot here.

---

#### Screenshot 3 — Output of `grep -n "try_files" /etc/nginx/sites-available/default`

Add your screenshot here.

---

### Notes

Answer the following in your own words:

**1. How do you confirm that the correct version of the application is deployed?**

Write your answer here.

---

# Task 6 — Nginx Configuration Failure Simulation

## Goal

Simulate a real-world Nginx misconfiguration and recover the service safely.

### Evidence

#### Screenshot 1 — Output of `sudo nginx -t` showing the syntax error (broken config)

Add your screenshot here.

---

#### Screenshot 2 — Output of `sudo nginx -t` showing syntax ok (fixed config)

Add your screenshot here.

---

#### Screenshot 3 — Output of `curl -I http://<public-ip>` confirming recovery (200 OK)

Add your screenshot here.

---

### Notes

Answer the following in your own words:

**1. What caused the configuration failure?**

Write your answer here.

---

**2. How did you fix the issue?**

Write your answer here.

---

**3. How can you avoid this kind of issue in real production systems?**

Write your answer here.

---

# Task 7 — Web Application Failure Simulation

## Goal

Simulate missing deployment content and recover the application safely.

### Evidence

#### Screenshot 1 — Output of `curl -I http://<public-ip>` showing failure (non-200 response)

Add your screenshot here.

---

#### Screenshot 2 — Output of `curl -I http://<public-ip>` confirming recovery (200 OK)

Add your screenshot here.

---

### Notes

Answer the following in your own words:

**1. What caused the application to break in this scenario?**

Write your answer here

---

**2. How did you fix the issue and restore the application?**

Write your answer here.

---

**3. What steps would you take to prevent this kind of issue in real production systems?**

Write your answer here.

---

# Task 8 — Security & Reliability Review

## Goal

Review and reflect on the security and reliability practices applied during this assignment.

### Security & Reliability Notes

Answer the following in your own words:

**1. Why is SSH key-based authentication more secure than sharing passwords?**

Write your answer here.

---

**2. Why should only required ports be open on a production server?**

Write your answer here.

---

**3. Why is it important for Nginx to be enabled on boot?**

Write your answer here.

---

**4. What are the risks of sharing secrets, keys, or credentials publicly?**

Write your answer here.

---

**5. Why should cloud resources be stopped or terminated when they are no longer needed?**

Write your answer here.

---

# LinkedIn Post (Required)

## Evidence

#### LinkedIn Post URL

Paste your LinkedIn post URL here:

`Add your URL here`

---

#### Screenshot — Published LinkedIn post

Add your screenshot here.

---

# Submission Instructions

- Add all required screenshots in your submission
- Full name must be visible in required screenshots
- Do not expose sensitive information (keys, passwords, account IDs)

---

# Completion Checklist

- [ ] Task 1: Screenshots (browser, ip a, ss -tulpen, ufw status) + Notes answered
- [ ] Task 2: Screenshots (nginx status, nginx -t, ss port 80) + Notes answered
- [ ] Task 3: Screenshots (access log, error log, journalctl) + Notes answered
- [ ] Task 4: Screenshots (uptime, free -h, df -h, du -sh) + Notes answered
- [ ] Task 5: Screenshots (ls html, grep deployed by, grep try_files) + Notes answered
- [ ] Task 6: Screenshots (nginx -t fail, nginx -t pass, curl recovery) + Notes answered
- [ ] Task 7: Screenshots (curl failure, curl recovery) + Notes answered
- [ ] Task 8: Security & Reliability Notes answered
- [ ] LinkedIn post published and URL submitted
- [ ] Full Name visible in all required screenshots
- [ ] No sensitive data exposed

---

## 📌 About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory) focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## 📌 Resources

- 🌐 DMI Official Website: https://dmi.pravinmishra.com?utm_source=github&utm_medium=readme  
- 🎓 University: https://university.pravinmishra.com?utm_source=github&utm_medium=readme  
- 💬 Discord Community: https://discord.pravinmishra.com?utm_source=github&utm_medium=readme  
- 📝 Blog: https://dmi.pravinmishra.com/blog?utm_source=github&utm_medium=readme  
- ▶️ YouTube Playlist: https://www.youtube.com/playlist?list=PLFeSNDtI4Cho  
- 🔗 Pravin Mishra (LinkedIn): https://www.linkedin.com/in/pravin-mishra-aws-trainer/  
- 🏢 CloudAdvisory (LinkedIn): https://www.linkedin.com/company/thecloudadvisory/

---

*This submission is part of DevOps Micro Internship (DMI) — Agentic AI Track.*