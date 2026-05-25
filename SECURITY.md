# Security Policy

## Scope

SANDEVISTAN is a wrapper around third-party offensive security tools. The
project itself does not contain exploit code — it orchestrates well-known
upstream tools. Vulnerabilities in the wrapper layer (e.g., command
injection, privilege escalation through the script, insecure download
paths) are in scope. Vulnerabilities in the wrapped tools themselves should
be reported to their respective upstream projects.

## Reporting a Vulnerability

Please **do not** open a public GitHub issue for security vulnerabilities.

To report a vulnerability:

1. Use GitHub's **private security advisories**:
   <https://github.com/WhiteMuush/sandevistan/security/advisories/new>
2. Or email the maintainer listed in [README.md](README.md) directly.

Please include:

- A description of the issue and its potential impact
- Steps to reproduce
- The affected version / commit SHA
- Any suggested mitigation

You will receive an acknowledgement within **5 business days**. We aim to
provide a fix or remediation plan within **30 days** of acknowledgement,
depending on complexity.

## Responsible Use

This toolkit is intended **strictly** for authorised security testing,
research, and education. Running these tools against systems for which you
do not have explicit, written authorisation is illegal in most jurisdictions
and is grounds for ban from the project community.

See the disclaimer in [README.md](README.md) for the full statement.
