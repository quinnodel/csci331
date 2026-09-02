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

✅ The published-URL form is **confirmed** by the Hello Server assignment text:

```
http://csci331vm.cs.montana.edu/<NetID>/
```

No tilde, no `.student.montana.edu` suffix in the path — the notes page
(`notes/publishing.html`) is simply typo'd, and prints three hostnames across
three lines (`csci331.cs.montana.edu`, `csci331vm.cs.montana.edu`,
`csci33vm1.cs.montana.edu`). Only `csci331vm.cs.montana.edu` resolves
(153.90.6.209). Ignore the other two.

Note the URL is **http**, not https, and reaching it requires the VPN when off
campus.

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

---

# Git workflow

Repo: **https://github.com/quinnodel/csci331** — public, default branch `main`.

Local pushes use HTTPS through the `gh` CLI credential helper; nothing to set up.

```
git add -A
git commit -m "..."
git push
```

## Pulling onto the course server

The repo is public, so the server needs no credentials at all. On the server,
once:

```
git clone https://github.com/quinnodel/csci331.git ~/csci331
~/csci331/bin/deploy.sh
```

Clone to `~/csci331`, **not** into `~/public_html`. Two reasons, neither about
secrecy: the repo root (`README.md`, `CLAUDE.md`, `assignments/`) is not the site
root Assignment 1 wants `index.html` at, and on an SELinux box files that were
not copied into `public_html` carry the wrong context and Apache 403s them.
`deploy.sh` handles both.

## The everyday loop

```
home:    edit → git add -A → git commit -m "..." → git push
server:  ~/csci331/bin/deploy.sh
```

`bin/deploy.sh` does `git pull --ff-only`, empties `~/public_html`, copies in the
assignment named in the `CURRENT` file, and fixes permissions. So the whole
deploy from your laptop, no login shell needed, is:

```
ssh -l <netid>@student.montana.edu csci331vm.cs.montana.edu '~/csci331/bin/deploy.sh'
```

To skip the NetID password prompt each time, put a laptop key on the VM once:
`ssh-copy-id -o User=<netid>@student.montana.edu csci331vm.cs.montana.edu`
(if the VM doesn't allow key auth you'll just keep typing the password — no harm).

**Switching which assignment is live:** edit `CURRENT` at home (one line, e.g.
`assignments/02-hypertext-forms`), commit, push, deploy. For a one-off without
touching `CURRENT`: `deploy.sh assignments/02-hypertext-forms`.

**Guard rails built in:**

| Situation | What the script does |
|---|---|
| Server copy was edited by hand | `--ff-only` pull refuses; fix by `git -C ~/csci331 reset --hard origin/main` |
| `~/public_html` has files it didn't put there | Refuses to wipe them; move them or `touch ~/public_html/.deployed-by-csci331` to hand over |
| `CURRENT` points at a missing dir | Exits before touching `public_html` |
| SELinux box | Runs `restorecon` on the docroot so Apache gets `httpd_user_content_t` |

`BRIEF.md` in an assignment dir is not published — it's a course note.

⚠️ Never edit files directly on the server. Edit locally, commit, push, deploy.

## On being public

The repo went public in Week 2 so the course server can pull it with a plain
`git clone` — no deploy key, no token, nothing to rotate or lose. Two consequences:

- **GitHub Pages is free** from a public repo (private needs Pro), which Assignment 1
  needs anyway for its live Pages link.
- **Anyone can read the solutions.** The conduct code forbids *submitting* someone
  else's work and *sharing verbatim code*; a public repo is not handing code to
  anyone, but if a classmate lifts from it you may still be asked about it. Don't
  link the repo in class channels, and keep it that way until grades are in.

The final project is graded on this repo, so public is where it had to end up
regardless.
