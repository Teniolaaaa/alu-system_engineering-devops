# Webstack Debugging 0 — Hello Holberton

This repository contains a small fix for the "Webstack debugging #0" challenge: ensure Apache serves a page that returns the string `Hello Holberton` at the web root.

What I created
- A short README that documents how to use the provided script and gives a small, safer alternative to the one-liner you provided.

Why this matters
- Containers used for the Holberton exercises usually run commands as root. Using `sudo` inside such scripts is unnecessary and may not be available in minimal images. Also, shell redirection with `sudo` (e.g. `sudo echo ... > /var/www/html/index.html`) does not work because the redirection is performed by the shell before `sudo` runs.
- The README explains how to run the container, how to run the script, and suggests a more robust variant that works both for root and non-root invocations.

Your original script
```bash
#!/usr/bin/env bash
# Fix Apache to return Hello Holberton

sudo service apache2 start
echo "Hello Holberton" > /var/www/html/index.html
```

Notes on the original
- It will work if:
  - `sudo` is installed and the script is run by a user allowed to use it without password prompts, and
  - Apache is already installed and configured.
- It can fail if the container does not have `sudo`, or if the user running the script is root (in which case `sudo` is redundant), or if Apache needs to be installed or restarted.

Recommended, more robust script
- This version detects whether it's run as root; if not, it uses `sudo` + `tee` so the redirection has proper permissions. It also installs Apache if missing and restarts the service so the new page is served.
```bash
#!/usr/bin/env bash
# Ensure Apache serves "Hello Holberton" at /

set -euo pipefail

MSG="Hello Holberton"
DOCROOT="/var/www/html/index.html"

# Helper to write to the file with proper permissions
if [ "$(id -u)" -eq 0 ]; then
  mkdir -p "$(dirname "$DOCROOT")"
  echo "$MSG" > "$DOCROOT"
  apt-get update -y || true
  if ! dpkg -s apache2 >/dev/null 2>&1; then
    apt-get install -y apache2
  fi
  service apache2 restart
else
  echo "$MSG" | sudo tee "$DOCROOT" >/dev/null
  sudo service apache2 restart
fi
```

How to use
1. Start the provided container (example):
   - docker run -p 8080:80 -d -it holbertonschool/265-0
2. Copy the script into the container, or edit/create `0-give_me_a_page` with the contents above.
3. Make it executable:
   - chmod +x 0-give_me_a_page
4. Run it inside the container:
   - ./0-give_me_a_page
5. From the host, test:
   - curl 0:8080
   - You should see: Hello Holberton

What I did and what's next
- I added this README to document the behavior and reasoning, showed the original snippet, and provided a safer alternative. If you'd like, I can open a small commit that replaces your one-liner with the recommended script, or produce a minimal version that intentionally keeps it simple (no install checks) to match the exercise constraints.

Thank you — nice job: your original one-liner will often work in practice. The README simply documents why and how to make it more reliable across environments
