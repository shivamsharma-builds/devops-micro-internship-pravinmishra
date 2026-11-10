# Capstone Assignment — Deploy the Book Review App Using Terraform and Claude Code Agentic AI

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Student Details

**Full Name:** Shivam Sharma
**Cloud Platform:** AWS or Azure  
**GitHub Repository URL:** `https://github.com/shivamsharma-builds/devops-micro-internship-pravinmishra`
**Public Application URL / Load-Balancer DNS:** `http://book-review-dev-public-alb-1645492623.eu-north-1.elb.amazonaws.com/`

---

## Purpose

Deploy the Book Review App using Terraform on AWS or Azure in a secure, highly available, production-style three-tier architecture. Use Claude Code, specialized subagents, Terraform MCP, and validation hooks to support the engineering workflow while keeping all infrastructure-changing operations under human control.

---

# Task 0 — Prepare the Project and Agentic AI Environment

## Goal

Prepare the Book Review App project and configure the provided Claude Code Agentic AI starter kit with project context, specialized subagents, Terraform MCP, validation hooks, and safety guardrails.

## Evidence

### Screenshot 1 — Project `CLAUDE.md`

Add a screenshot of the project `CLAUDE.md` showing the three-tier architecture, security boundaries, Terraform requirements, and human-approval rules.

![Screenshot](screenshots/Assignment5.Task0.ss1.png)

![Screenshot](screenshots/Assignment5.Task0.ss1i.png)

---

### Screenshot 2 — Terraform Engineer Subagent

Add a screenshot showing the Terraform Engineer subagent configuration.

![Screenshot](screenshots/Assignment5.Task0.ss2.png)

---

### Screenshot 3 — Architecture and Security Reviewer Subagent

Add a screenshot showing the Architecture and Security Reviewer subagent configuration.

![Screenshot](screenshots/Assignment5.Task0.ss3.png)

---

### Screenshot 4 — Terraform MCP Connection

Add a screenshot showing Terraform MCP connected and available.

![Screenshot](screenshots/Assignment5.Task0.ss4.png)

---

### Screenshot 5 — Validation Hooks

Add a screenshot showing the configured Claude Code validation hooks.

![Screenshot](screenshots/Assignment5.Task0.ss5.png)

---

# Task 1 — Design the Three-Tier Architecture

## Goal

Design the required secure, highly available three-tier architecture and create an architecture diagram before building the infrastructure.

The diagram must show:

- VPC or VNet
- Availability Zones or equivalent availability locations
- Six subnets
- Internet connectivity
- NAT or outbound design
- Public load balancer
- Web Tier
- Internal load balancer
- Application Tier
- Managed MySQL
- Read replica
- Main traffic flow

## Architecture Diagram

![Screenshot](screenshots/Assignment5.Task1.ss.jpg)

---

# Task 2 — Build the Terraform Networking and Security Layers

## Goal

Create the modular Terraform project and implement the network and security layers across the required public and private subnets.

## Evidence

### Screenshot 6 — Modular Terraform Project Structure

Add a screenshot showing the modular Terraform project structure.

![Screenshot](screenshots/Assignment5.Task2.ss6.png)

---

### Screenshot 7 — Six-Subnet Architecture

Add a screenshot showing the six-subnet architecture across two availability locations.

![Screenshot](screenshots/Assignment5.Task2.ss7.png)

---

### Screenshot 8 — Public and Private Tier Separation

Add a screenshot showing the public and private tier separation, including routing and security boundaries.

![Screenshot](screenshots/Assignment5.Task2.ss8.png)

![Screenshot](screenshots/Assignment5.Task2.ss8i.png)

---

# Task 3 — Build the Load-Balancing and Compute Layers

## Goal

Deploy the public and internal load balancers and the Web and Application compute resources required by the Book Review App.

## Evidence

### Screenshot 9 — Web and Application Compute

Add a screenshot showing the Web and Application compute resources in their required subnets.

![Screenshot](screenshots/Assignment5.Task3.ss9.png)

---

### Screenshot 10 — Public Load Balancer

Add a screenshot showing the internet-facing public load balancer.

![Screenshot](screenshots/Assignment5.Task3.ss10.png)

---

### Screenshot 11 — Internal Load Balancer

Add a screenshot showing the private internal load balancer.

![Screenshot](screenshots/Assignment5.Task3.ss11.png)

---

### Screenshot 12 — Healthy Targets

Add a screenshot showing healthy target groups or backend pools.

![Screenshot](screenshots/Assignment5.Task3.ss12.png)


---

# Task 4 — Build the Managed MySQL Database Layer

## Goal

Deploy a private, highly available managed MySQL database with a read replica and restrict database connectivity to the Application Tier.

## Evidence

### Screenshot 13 — Managed MySQL Database

Add a screenshot showing the managed MySQL database deployment.

![Screenshot](screenshots/Assignment5.Task4.ss13.png)

---

### Screenshot 14 — High Availability

Add a screenshot showing the Multi-AZ or high-availability configuration.

![Screenshot](screenshots/Assignment5.Task4.ss14.png)

---

### Screenshot 15 — Read Replica

Add a screenshot showing the read replica configuration.

![Screenshot](screenshots/Assignment5.Task4.ss15.png)

---

### Screenshot 16 — Private Database Access

Add a screenshot showing that the database is private and accepts MySQL traffic only from the Application Tier.

![Screenshot](screenshots/Assignment5.Task4.ss16.png)

---

# Task 5 — Validate, Review, and Apply the Terraform Configuration

## Goal

Validate the Terraform configuration, review the execution plan using both Agentic AI and human judgment, and apply the infrastructure changes only after all required checks pass.

## Evidence

### Screenshot 17 — Terraform Validation

Add a screenshot showing successful `terraform validate` output.

![Screenshot](screenshots/Assignment5.Task5.ss17.png)

---

### Screenshot 18 — Terraform Plan

Add a screenshot showing the Terraform plan output.

![Screenshot](screenshots/Assignment5.Task5.ss18.png)

---

### Screenshot 19 — Terraform Apply

Add a screenshot showing successful `terraform apply` completion.

![Screenshot](screenshots/Assignment5.Task5.ss19.png)

---

# Task 6 — Deploy and Configure the Book Review Application

## Goal

Deploy and configure the Book Review App across the Web, Application, and Database tiers and verify the complete application functionality.

## Evidence

### Screenshot 20 — Homepage

Add a screenshot showing the Book Review App homepage through the public endpoint.

![Screenshot](screenshots/Ass5.Task6.ss20.jpg)

---

### Screenshot 21 — Login or Authentication

Add a screenshot showing successful login or authentication.

![Screenshot](screenshots/Ass5.Task6.ss21.jpg)

---

### Screenshot 22 — Book Data

Add a screenshot showing the book listing or book details.

![Screenshot](screenshots/Ass5.Task6.ss22.jpg)

---

### Screenshot 23 — Review Functionality

Add a screenshot showing the review functionality working successfully.

![Screenshot](screenshots/Ass5.Task6.ss23.jpg)

---

### Screenshot 24 — Backend or API Evidence

Add a screenshot showing that the backend or API is working successfully.

![Screenshot](screenshots/Ass5.Task6.ss24.jpg)

---

### Screenshot 25 — Database Reads and Writes

Add a screenshot showing successful database reads and writes.

![Screenshot](screenshots/Ass5.Task6.ss25.jpg)

## Public Application URL

**Public Application URL / DNS:** `http://book-review-dev-public-alb-1645492623.eu-north-1.elb.amazonaws.com/`

---

# Task 7 — Demonstrate the Agentic AI Workflow

## Goal

Demonstrate how Claude Code assisted with Terraform generation, architecture and security review, and evidence-based troubleshooting while infrastructure-changing decisions remained under human control.

You do not need to submit your complete Claude Code conversation history. Include only focused evidence.

## Evidence

### Screenshot 26 — AI-Assisted Terraform Generation

Add a screenshot showing one useful example of AI-assisted Terraform generation or improvement.

![Screenshot](screenshots/Ass5.Task7.ss26.jpg)

---

### Screenshot 27 — Architecture or Security Review

Add a screenshot showing one structured architecture or security review result.

![Screenshot](screenshots/Ass5.Task7.ss27.jpg)

---

### Screenshot 28 — AI-Assisted Troubleshooting

Add a screenshot showing one AI-assisted troubleshooting interaction based on collected evidence.

![Screenshot](screenshots/Ass5.Task7.ss28.jpg)

---

# Task 8 — Complete the Final Architecture Review

## Goal

Review the completed infrastructure against the original capstone requirements and resolve significant architecture, security, reliability, and cost issues.

Confirm that the final review covers:

- Tier separation
- Availability
- Public exposure
- Routing
- Security rules
- Load balancing
- Database privacy
- Secrets
- Terraform quality
- Module structure
- Reliability
- Obvious cost risks

Use Screenshot 27 as the focused evidence for the structured architecture or security review.

---

# Task 9 — Answer the Reflection Questions

## Goal

Reflect on the architecture, Terraform implementation, and Agentic AI workflow. Answer each question briefly in your own words.

## Architecture

### 1. Why did you separate the Web, Application, and Database tiers?

I separated the Web, Application, and Database tiers to improve security, scalability, and maintainability. Each tier has a specific responsibility, so changes or problems in one layer do not directly affect the others.

### 2. Why is the Application Tier private?

The Application Tier is private so users cannot access the application servers directly from the internet. Only the Web Tier can communicate with the Application Tier, which reduces the attack surface and improves security

### 3. Why is MySQL private?

MySQL is private because the database should not be directly accessible from the internet. Only the Application Tier should be allowed to connect to the database through the required database port.

### 4. Why are multiple Availability Zones used?

I used multiple Availability Zones to improve availability and fault tolerance. If one Availability Zone experiences a failure, resources in another Availability Zone can continue serving the application.

### 5. What is the difference between Multi-AZ/high availability and a read replica?

Multi-AZ is mainly for high availability and failover. A standby database can take over when the primary fails. A read replica is mainly used to handle read traffic and improve read performance. A read replica is not the same as a high-availability standby.

## Terraform

### 6. How did you divide your Terraform into modules?

I divided the Terraform configuration into reusable modules based on the architecture. The main modules include Network, Security, Load Balancer, Compute, and Database. This keeps the configuration organized and easier to maintain.

### 7. How do the modules communicate through variables and outputs?

Modules receive information through input variables and expose important resources through outputs. For example, the Network module outputs subnet and VPC information that other modules can use without hard-coding those values.

### 8. What did you specifically check in `terraform plan`?

I checked that Terraform was creating the expected resources and that there were no unexpected changes or destructive actions. I also reviewed networking, security groups, subnets, load balancers, EC2 resources, and database configuration before applying the plan.

## Agentic AI

### 9. What was the purpose of `CLAUDE.md`?

`CLAUDE.md` provided Claude with the project's instructions, architecture requirements, security rules, workflow, and restrictions. It helped keep Claude's work aligned with the project's goals and prevented unsafe actions.

### 10. What work did the Terraform Engineer subagent perform?

The Terraform Engineer subagent helped design and review the Terraform infrastructure. It worked through the required architecture, modules, networking, security, and AWS resources while following the project instructions.

### 11. What did the Architecture and Security Reviewer identify?

The Architecture and Security Reviewer checked the design for security and architectural weaknesses. It helped identify areas such as network exposure, security-group rules, private resources, access controls, and whether the architecture followed the required three-tier design.

### 12. Why did you use Terraform MCP instead of relying only on Claude's existing Terraform knowledge?

I used Terraform MCP to give Claude access to more reliable and current Terraform-related information and tools. This reduced the risk of relying only on its existing knowledge and helped validate Terraform resources and configurations against available documentation.

### 13. What was the purpose of your validation hooks?

The validation hooks acted as guardrails around the Agentic AI workflow. They helped check commands and Terraform-related actions before or after execution, preventing unsafe operations and providing logging or validation where necessary.

### 14. Describe one real issue Claude helped you troubleshoot.

One real issue was troubleshooting the application deployment when the Application Load Balancer target health was not healthy. Claude helped me investigate the target group, instance health, application port, and backend configuration to identify where the communication problem was occurring.

### 15. Describe one recommendation you reviewed, modified, or rejected instead of accepting blindly.

One recommendation I reviewed was related to infrastructure changes and deployment actions. Instead of allowing Claude to apply or destroy resources automatically, I followed the project guardrails and reviewed the Terraform plan myself before making changes. This helped me remain in control of potentially costly or destructive operations.

---

# Task 10 — Publish the Mandatory LinkedIn Post

## Goal

Publish a LinkedIn post describing the capstone, the technical work completed, the Agentic AI workflow, and the lessons learned.

Write the post in your own words, include at least one project image or other proof, and ensure that it can be viewed by the submission reviewer.

## LinkedIn Post URL

**LinkedIn Post URL:** [Linkedin post](https://www.linkedin.com/posts/shivamsharma-builds_dmibypravinmishra-devops-terraform-share-7523994023133388800-L4QO)

---

# Submission Instructions

- Complete Tasks 0–10 in sequence.
- Include all Screenshots 1–28 exactly as specified.
- Ensure that your full name is visible in the required screenshots.
- Include the selected cloud platform.
- Include the completed architecture diagram.
- Include the modular Terraform project structure.
- Include the working public application URL or public load-balancer DNS.
- Include all required Agentic AI workflow evidence.
- Answer all 15 reflection questions briefly in your own words.
- Include the published LinkedIn post URL.
- Do not expose cloud credentials, database passwords, SSH private keys, JWT secrets, access tokens, account IDs, Terraform state containing sensitive values, or other confidential information.
- Review all screenshots and project files carefully before submitting through GitHub.

---

# Completion Checklist

- [✅] Selected AWS or Azure
- [✅] Added and reviewed the Agentic AI starter files
- [✅] Configured `CLAUDE.md`
- [✅] Configured the Terraform Engineer subagent
- [✅] Configured the Architecture and Security Reviewer subagent
- [✅] Connected Terraform MCP
- [✅] Configured validation hooks and safety guardrails
- [✅] Created the architecture diagram
- [✅] Created the six-subnet design
- [✅] Configured public Web Tier routing
- [✅] Kept the Application Tier private
- [✅] Kept the Database Tier private
- [✅] Configured tier-specific Security Groups or NSGs
- [✅] Restricted backend port `3001`
- [✅] Restricted MySQL port `3306` to the Application Tier
- [✅] Created the public load balancer
- [✅] Created the internal load balancer
- [✅] Configured listeners and health checks
- [✅] Deployed the Web Tier compute resources
- [✅] Deployed the private Application Tier compute resources
- [✅] Provisioned private managed MySQL
- [✅] Configured Multi-AZ or high availability
- [✅] Configured a read replica
- [✅] Created the modular Terraform project
- [✅] Used variables, outputs, and module dependencies
- [✅] Used current Terraform documentation through MCP
- [✅] Used hooks for deterministic validation
- [✅] Completed `terraform fmt`
- [✅] Completed `terraform validate`
- [✅] Reviewed `terraform plan`
- [✅] Completed the Terraform Engineer review
- [✅] Completed the Architecture and Security review
- [✅] Applied the infrastructure only after human approval
- [✅] Deployed and configured the backend
- [✅] Deployed and configured the frontend
- [✅] Configured Nginx where required
- [✅] Configured the internal backend endpoint
- [✅] Configured the public frontend endpoint
- [✅] Verified the homepage
- [✅] Verified login or authentication
- [✅] Verified book data
- [✅] Verified review functionality
- [✅] Verified the backend API
- [✅] Verified database reads and writes
- [✅] Verified healthy load-balancer targets
- [✅] Included AI-assisted Terraform generation evidence
- [✅] Included one architecture or security review
- [✅] Included one AI-assisted troubleshooting example
- [✅] Completed the final architecture review
- [✅] Answered all 15 reflection questions
- [✅] Published the mandatory LinkedIn post
- [✅] Added the LinkedIn post URL
- [✅] Captured all 28 required screenshots
- [✅] Confirmed that my full name is visible in the required screenshots
- [✅] Checked that no secrets or sensitive information are exposed

---

## About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory), focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations through hands-on experience.

---

## Resources

- Book Review App Repository: [https://github.com/pravinmishraaws/book-review-app](https://github.com/pravinmishraaws/book-review-app)
- DMI Official Website: [https://dmi.pravinmishra.com](https://dmi.pravinmishra.com)
- University: [https://university.pravinmishra.com](https://university.pravinmishra.com)
- Discord Community: [https://discord.pravinmishra.com](https://discord.pravinmishra.com)
- Blog: [https://dmi.pravinmishra.com/blog](https://dmi.pravinmishra.com/blog)
- YouTube Playlist: [https://www.youtube.com/playlist?list=PLFeSNDtI4Cho](https://www.youtube.com/playlist?list=PLFeSNDtI4Cho)
- Pravin Mishra on LinkedIn: [https://www.linkedin.com/in/pravin-mishra-aws-trainer/](https://www.linkedin.com/in/pravin-mishra-aws-trainer/)
- CloudAdvisory on LinkedIn: [https://www.linkedin.com/company/thecloudadvisory/](https://www.linkedin.com/company/thecloudadvisory/)

---

*This submission is part of the DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
