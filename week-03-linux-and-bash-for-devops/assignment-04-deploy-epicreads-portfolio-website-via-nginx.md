# Assignment 4 — Deploy EpicReads Portfolio Website via Nginx

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will deploy a static portfolio website on an Ubuntu VM using Nginx. You will download the website template, add your ownership proof in the footer, deploy the files to the Nginx web root, and verify the website is publicly accessible via a browser.

---

# Task 0 — Pre-flight Check

## Goal

Verify the Ubuntu VM and Nginx are ready for deployment.

### Evidence

#### Screenshot 0 — Output of `sudo systemctl status nginx --no-pager` showing Active (running)

![Task 0 Screenshot](screenshots/assignment-04-task-00-01.png)

---

# Task 1 — Get the Website Source Code

## Goal

Download and extract the portfolio website template.

### Evidence

#### Screenshot 1 — Output of `ls -la` showing the extracted project folder

![Task 1 Screenshot](screenshots/assignment-04-task-01-01.png)

---

# Task 2 — Add Ownership Proof (Anti-Copy Change)

## Goal

Update the website footer with your deployment details.

### Evidence

#### Screenshot 2 — Nano editor open with the updated footer showing your Full Name, Group, Week, and Date

![Task 2 Screenshot](screenshots/assignment-04-task-02.png)

---

# Task 3 — Deploy Website via Nginx

## Goal

Deploy the portfolio website to the Nginx web root.

### Evidence

#### Screenshot 3 — Output of `sudo nginx -t` showing configuration test successful

![Task 3 Screenshot](screenshots/assignment-04-task-03-01.png)

---

#### Screenshot 4 — Output of `ls /var/www/html` showing deployed website files

![Task 3 Screenshot](screenshots/assignment-04-task-03-02.png)

---

# Task 4 — Verify Website is Live

## Goal

Verify the deployed website is publicly accessible and the footer contains your details.

### Evidence

#### Screenshot 5 — Output of `curl ifconfig.me` showing the server's public IP address

![Task 4 Screenshot](screenshots/assignment-04-task-04-01.png)

---

#### Screenshot 6 — Browser showing the live website with your Full Name and deployment details in the footer

![Task 4 Screenshot](screenshots/assignment-04-task-04-02.png)

---

# Task 5 — Mini Real DevOps Operational Check

## Goal

Verify the deployed website and Nginx service are healthy.

### Evidence

#### Screenshot 7 — Output of `systemctl is-enabled nginx`

![Task 5 Screenshot](screenshots/assignment-04-task-05-01.png)

---

#### Screenshot 8 — Output of `curl -I http://localhost` showing 200 OK

![Task 5 Screenshot](screenshots/assignment-04-task-05-02.png)

---

# LinkedIn Post (Mandatory)

## Evidence

#### LinkedIn Post URL

Paste your LinkedIn post URL here:

`https://www.linkedin.com/posts/shivamsharma-builds_devops-nginx-ubuntu-share-7511310356401659904-1e-k`

---

#### Screenshot — Published LinkedIn post showing the live website with your Full Name in the footer

![Task 6 Screenshot](screenshots/assignment-04-linkedin.png)

---

# Submission Instructions

- Add all required screenshots in your submission
- Full name must be visible in required screenshots
- Ownership proof in the footer is mandatory
- Do not expose sensitive information (keys, passwords, account IDs)

---

# Completion Checklist

- [✅] Screenshot 0: Nginx service status (active/running)
- [✅] Screenshot 1: Website files downloaded and extracted
- [✅] Screenshot 2: Footer updated with Full Name, Group, Week, and Date
- [✅] Screenshot 3: Nginx configuration test successful
- [✅] Screenshot 4: Website files deployed to /var/www/html
- [✅] Screenshot 5: Public IP retrieved
- [✅] Screenshot 6: Live website accessible in browser with footer details
- [✅] Screenshot 7: Nginx enabled on boot
- [✅] Screenshot 8: Local HTTP response returns 200 OK
- [✅] LinkedIn post published and URL submitted
- [✅] Full Name visible in all required screenshots
- [✅] No sensitive data exposed

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