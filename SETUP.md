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

---

# Git workflow

Repo: **https://github.com/quinnodel/csci331** — private, default branch `main`.

Local pushes use HTTPS through the `gh` CLI credential helper; nothing to set up.

```
git add -A
git commit -m "..."
git push
```

## Pulling onto the course server

The repo is private, so `csci331vm` needs its own credentials. Use a **read-only
deploy key** — a keypair that grants access to this one repo and nothing else.
Do NOT put a personal access token on a shared university VM: a PAT carries your
whole account, a deploy key carries one repo, read-only.

Run these **on the server**, once:

```
ssh -l <netid>@student.montana.edu csci331vm.cs.montana.edu

ssh-keygen -t ed25519 -f ~/.ssh/csci331_deploy -N "" -C "csci331vm deploy key"
cat ~/.ssh/csci331_deploy.pub
```

Then, in the repo's settings on GitHub — Settings → Deploy keys → Add deploy key —
paste that public key, title it `csci331vm`, and **leave "Allow write access"
unchecked**.

Back on the server, tell SSH to use that key for GitHub:

```
cat >> ~/.ssh/config <<'CONF'
Host github.com
  IdentityFile ~/.ssh/csci331_deploy
  IdentitiesOnly yes
CONF
chmod 600 ~/.ssh/config

git clone git@github.com:quinnodel/csci331.git ~/csci331
```

From then on, deploying is:

```
cd ~/csci331 && git pull
```

## Serving the pulled work out of public_html

The server serves `~/public_html/`. The repo holds many assignments, so publish
whichever one is current by symlinking it:

```
ln -sfn ~/csci331/assignments/01-publishing-content ~/public_html
```

Re-point that symlink when a new assignment goes live. If symlink-following is
disabled on the VM, clone straight into `~/public_html` instead and keep only the
current assignment's files at its root.

⚠️ Never edit files directly on the server. Edit locally, commit, push, pull. A
`git pull` onto edited files either conflicts or clobbers.

## Going public for the final project

The final project is graded on the published site **and** the GitHub repo, so it
must be visible to the instructor by finals week. Two options then:

1. Flip this repo to public — `gh repo edit --visibility public`
2. Keep it private and add the instructor as a collaborator

Keeping it private during the term means classmates cannot copy your solutions,
which is the reason for the split. GitHub Pages from a private repo needs GitHub
Pro — free via the Student Developer Pack (https://education.github.com/pack) if
you want Pages before then.
