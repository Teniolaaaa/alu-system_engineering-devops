# SSH Project

This project covers core SSH concepts and how to use SSH keys to securely connect to a remote Ubuntu server, as part of the ALU System Engineering DevOps curriculum.

## Files

### 0-use_a_private_key
Bash script that connects to your server as the `ubuntu` user using the private key `~/.ssh/school`.
- Usage:  
  ```bash
  ./0-use_a_private_key
  ```
- The server address is set to `6924-web-01` (replace with your server's IP or hostname as needed).

### 1-create_ssh_key_pair
Bash script to create an RSA key pair named `school` with 4096 bits and the passphrase `betty`.
- Usage:  
  ```bash
  ./1-create_ssh_key_pair
  ```
- Generates two files: `school` (private key), `school.pub` (public key).

### 2-ssh_config
SSH client configuration. Configures the `ssh` client to use the private key `~/.ssh/school` for the server and refuses password authentication.
- Place contents in `~/.ssh/config` for ease of use.
- Example:
  ```
  Host 6924-web-01
      HostName 6924-web-01
      User ubuntu
      IdentityFile ~/.ssh/school
      PasswordAuthentication no
  ```

### "Let me in!"
To give project graders access, add the following public key to `/home/ubuntu/.ssh/authorized_keys` on your server:
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNdtrNGtTXe5Tp1EJQop8mOSAuRGLjJ6DW4PqX4wId/Kawz35ESampIqHSOTJmbQ8UlxdJuk0gAXKk3Ncle4safGYqM/VeDK3LN5iAJxf4kcaxNtS3eVxWBE5iF3FbIjOqwxw5Lf5sRa5yXxA8HfWidhbIG5TqKL922hPgsCGABIrXRlfZYeC0FEuPWdr6smOElSVvIXthRWp9cr685KdCI+COxlj1RdVsvIo+zunmLACF9PYdjB2s96Fn0ocD3c5SGLvDOFCyvDojSAOyE70ebIElnskKsDTGwfT4P6jh9OBzTyQEIS2jOaE5RQq4IB4DsMhvbjDSQrP0MdCLgwkN
```

## Key Concepts

- **What is a server?**  
  A server is a powerful computer designed to provide services, host applications, or manage resources for other computers (clients) in a network.

- **Where do servers usually live?**  
  Servers typically reside in data centers, which provide infrastructure such as cooling, networking, electricity, and physical security.

- **What is SSH?**  
  **SSH (Secure Shell)** is a cryptographic protocol that allows secure remote communication and login between computers.

- **How to create an SSH RSA key pair?**  
  Use `ssh-keygen` to generate a public/private key pair:  
  ```bash
  ssh-keygen -t rsa -b 4096 -f school -N betty
  ```

- **How to connect using the SSH RSA key pair?**  
  Provide the private key with the `-i` flag to `ssh`:
  ```bash
  ssh -i ~/.ssh/school ubuntu@your-server-ip
  ```

- **Why use `#!/usr/bin/env bash` instead of `/bin/bash`?**  
  Using `#!/usr/bin/env bash` makes scripts more portable, as it finds the `bash` interpreter according to the user's `PATH`, regardless of where it’s installed.

## Usage

1. **Make scripts executable**
   ```bash
   chmod +x 0-use_a_private_key 1-create_ssh_key_pair
   ```
2. **Run scripts as described above**

## References

- [What is a server?](https://www.cloudflare.com/en-gb/learning/server/)
- [SSH Essentials](https://www.ssh.com/academy/ssh)
- `man ssh`
- `man ssh-keygen`
