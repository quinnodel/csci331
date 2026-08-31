# Setup — tools, accounts, and the course server

## Software (Week 1 expects these installed)

| Tool | Purpose | Source |
|---|---|---|
| VS Code | editor (or equivalent) | https://code.visualstudio.com/ |
| Git | version control | https://git-scm.com/book/en/v2/Getting-Started-Installing-Git |
| GitHub account | required, free | https://github.com/ |
| AMPPS or MAMP | localhost stack, needed ~Week 5–6 | https://ampps.com/ · https://www.mamp.info/ |
| FileZilla | FTP | https://filezilla-project.org/ |
| MSU VPN client | off-campus access to the course server | https://www.montana.edu/uit/computing/desktop/vpn/ |

Nothing but the GitHub account is strictly required by the syllabus; the rest are
what the course uses. AMPPS/MAMP can wait until localhost shows up in Week 5.

## Course server

Host: **`csci331vm.cs.montana.edu`** — a VPS on the MSU-Secure network, maintained
by Scott Dowdle. Authenticates with your MSU NetID and password.

```
ssh -l <netid>@student.montana.edu csci331vm.cs.montana.edu
```

Serve pages out of `public_html/`, i.e. `public_html/index.html`.

Access requires being on **MSU-Secure Wi-Fi** on campus, or connected through the
**MSU VPN** off campus.

⚠️ The published-URL line on the notes page (`notes/publishing.html`) is typo'd —
it prints three different hostnames across three lines: `csci331.cs.montana.edu`,
`csci331vm.cs.montana.edu`, and `csci33vm1.cs.montana.edu`. Only the middle one
resolves (153.90.6.209); the other two are NXDOMAIN. So the live URL is almost
certainly:

```
csci331vm.cs.montana.edu/~<netID>.student.montana.edu/index.html
```

Confirm the exact form in class — the tilde-path convention is unusual enough to
be worth one question rather than an hour of guessing.

## Reading the course assigned (MDN)

- Getting Started with the Web
- Installing basic software
- Publishing your website
- How the web works
- Dealing with files
- Web mechanics

## GitHub Pages

Week 1 and Week 2 both ask you to publish a basic HTML page via GitHub Pages,
following MDN's publishing instructions. That is separate from the course server —
you end up with two publishing paths, and the final project needs both a published
site and a GitHub repo.

## Validators — run before every markup/CSS submission

- HTML: https://validator.w3.org/
- CSS: https://jigsaw.w3.org/css-validator/
