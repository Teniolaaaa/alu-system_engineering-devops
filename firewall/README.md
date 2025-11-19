ll (ufw) — README

This folder contains the solution for the "Firewall" project task: configure UFW on the web-01 server so that all incoming traffic is blocked except for SSH (22), HTTP (80) and HTTPS (443).

Important
- Do NOT run these commands inside the school "containers on demand" or other restricted containers. UFW requires access to kernel netfilter modules and sysctl. If you run inside an unprivileged container you will see errors like:
  - "iptables v1.4.21: can't initialize iptables table `filter': Permission denied"
  - "sysctl: setting key ... Read-only file system"
- Always allow SSH BEFORE enabling UFW, otherwise you may lock yourself out of the VM.
- Run the commands on the real VM for web-01 (example: ssh ubuntu@13.220.103.184). If your school network blocks connections, run tests from web-02 as described below.

Files
- 0-block_all_incoming_traffic_but
  - Plain text file containing the exact commands used to configure UFW for this task.

What to do (commands)
1. Update and install ufw
sudo apt-get update -y
sudo apt-get install -y ufw

2. Allow SSH (critical — do this first)
sudo ufw allow 22/tcp
# OR: sudo ufw allow OpenSSH

3. Allow HTTP and HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

4. Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

5. Enable UFW
sudo ufw --force enable

6. Verify status
sudo ufw status verbose

Testing
- From another host (for example, web-02) verify allowed ports respond and others are blocked using telnet:
  - telnet <web-01-IP> 22   # should connect (SSH banner)
  - telnet <web-01-IP> 80   # should connect
  - telnet <web-01-IP> 443  # may show "Protocol mismatch." but should connect
  - telnet <web-01-IP> 2222 # should NOT connect (will hang and fail)

Troubleshooting
- If you see iptables/modprobe/sysctl permission errors, you are likely inside a restricted container. Solution: SSH to the real web-01 VM and run the commands there with sudo.
- If you accidentally lock yourself out (you disabled SSH before enabling ufw), you will need console access to the VM to restore connectivity — avoid doing this.

Notes
- The requirement for the project is: "Configure ufw so that it blocks all incoming traffic except TCP ports 22, 80 and 443." The commands above implement exactly that.
- The file `0-block_all_incoming_traffic_but` in this directory contains the same commands condensed in one script form for convenience.

Example (contents of 0-block_all_incoming_traffic_but)
sudo apt-get update -y
sudo apt-get install -y ufw
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force enable
sudo ufw status verbose

Security reminder
- Double-check which SSH port you use. If your SSH is not on the standard port 22, allow the correct port before enabling UFW.
- Keep a separate rescue/console access plan in case of accidental lockout.

If you want, I can:
- Add this README.md to the repository for you, or
- Create a small checklist/script that you can run on web-01 to apply and verify the rules.
