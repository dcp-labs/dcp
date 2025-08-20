## 🔑 GitHub SSH Setup Guide

This guide explains how to create SSH keys, configure them for GitHub, and make them load automatically on login.

<br>

### 1️⃣ Generate a New SSH Key

Run the following command to create a new SSH key named `github`:

```bash
ssh-keygen -t ed25519 -C "test@gmail.com" -f "github"
```

This will generate:

* `~/.ssh/github` → private key (keep safe, never share)
* `~/.ssh/github.pub` → public key (upload to GitHub)

<br>

### 2️⃣ Add Public Key to GitHub

Print the key:

```bash
cat ~/.ssh/github.pub
```

Copy the output, then go to:

* GitHub → **Settings** → **SSH and GPG keys** → **New SSH key**
* Paste the key → Save

<br>

### 3️⃣ Configure SSH to Use the Key

Edit the SSH config file:

```bash
vi ~/.ssh/config
```

Add:

```
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github
    AddKeysToAgent yes
```

This tells SSH to always use your `github` key for GitHub connections.

<br>

### 4️⃣ Auto-Load Keys on Login

Edit your `~/.bashrc`:

```bash
vi ~/.bashrc
```

Add these lines at the bottom:

```bash
# Start SSH agent
eval "$(ssh-agent -s)" > /dev/null

# Add keys if not already loaded
ssh-add -l | grep -q github          || ssh-add -q ~/.ssh/github
ssh-add -l | grep -q github_personal || ssh-add -q ~/.ssh/github_personal
ssh-add -l | grep -q github_work     || ssh-add -q ~/.ssh/github_work
```

Reload your shell:

```bash
source ~/.bashrc
```

Now your keys will load automatically every time you log in.

<br>

### 5️⃣ Test the Connection

Run:

```bash
ssh -T git@github.com
```

You should see:

```
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

<br>

### 6️⃣ Link Your Repo

Inside your project folder, set the remote origin (replace `username` and `reponame`):

```bash
git remote add origin git@github.com:username/reponame.git
```

Push your changes:

```bash
git push origin master
```

<br>

✅ Done! Your SSH setup is complete — from now on, Git will connect to GitHub securely using your SSH key(s).

<br>
<br>

---

<br>
<br>
