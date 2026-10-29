---
name: azure-audit
description: Run the read-only Azure security-posture audit, analyze the evidence, explain security or operational impact, and recommend remediation commands without executing them.
allowed-tools: Bash, Read, Grep
disable-model-invocation: true
---

# Azure Audit Skill

When `/azure-audit` is invoked:

1. Read `CLAUDE.md` before doing anything else.

2. Run:

   `bash scripts/azure-audit.sh || true`

3. Read:

   `reports/azure-security-report.txt`

4. Report:

   - Overall status
   - Every WARN or FAIL finding
   - Exact evidence from the report
   - Security or operational impact of each finding
   - One exact Azure CLI remediation command for the human to review
   - One read-only verification command

5. If every check passes, clearly state that no remediation action is required.

6. Do not edit files.

7. Do not run any Azure CLI command that creates, modifies, resizes, starts, stops, deallocates, or deletes a resource.

8. Never execute the recommended remediation command.

9. Ask the human operator to review and execute any remediation command manually.
