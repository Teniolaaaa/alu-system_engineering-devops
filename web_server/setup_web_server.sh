#!/usr/bin/env bash
# Configures Ubuntu server with Nginx for Tasks 1–5

# Update package list
apt-get update -y

# Install Nginx
apt-get install -y nginx

# Create directories
mkdir -p /usr/share/nginx/html

# Task 1: Create main page
echo "Holberton School for the win!" > /usr/share/nginx/html/index.html

# Task 4 & 5: Create beautiful 404 page
cat > /usr/share/nginx/html/404.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>404 - Page Not Found</title>
    <style>
        body { text-align: center; font-family: Arial, sans-serif; background: #f4f4f9; color: #333; padding-top: 50px; }
        h1 { font-size: 80px; color: #e74c3c; }
        p { font-size: 24px; }
        a { text-decoration: none; color: #3498db; font-weight: bold; }
        a:hover { color: #2c3e50; }
    </style>
</head>
<body>
    <h1>404</h1>
    <p>Ceci n'est pas une page</p>
    <p>Oops! The page you requested cannot be found.</p>
    <p><a href="/">Go back to Home</a></p>
    <img src="https://http.cat/404" alt="404 Cat" style="margin-top:20px; max-width:50%;">
</body>
</html>
EOF

# Task 3 & Nginx config: overwrite default site config
cat > /etc/nginx/sites-enabled/default <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;

    root /usr/share/nginx/html;
    index index.html index.htm;

    server_name localhost;

    # Main page
    location / {
        try_files \$uri \$uri/ =404;
    }

    # Redirection
    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }

    # Custom 404 page
    error_page 404 /404.html;
    location = /404.html {
        root /usr/share/nginx/html;
        internal;
    }
}
EOF

# Test Nginx configuration
nginx -t

# Restart Nginx
service nginx restart

