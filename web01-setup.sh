sudo -i
apt update && apt upgrade -y
apt install nginx -y

# we are using ip_hash for load balancing as it will always send the same client to the same server, which is good for session management in our case

# http_host for port forwarding and remote_addr for client ip address forwarding to the app servers, so that we can see the real client ip in our application logs instead of nginx server ip. X-Forwarded-For is used to keep track of all the proxies through which the request has passed. X-Forwarded-Proto is used to indicate whether the original request was HTTP or HTTPS.

# we are also using max_fails and fail_timeout to mark the server as down if it fails 3 times within 30 seconds, so that nginx will stop sending requests to that server until it comes back up. This is a simple way to achieve high availability for our application.
cat <<EOF > /etc/nginx/sites-available/vproapp
upstream vproapp {
    ip_hash;
    server app01:8080 max_fails=3 fail_timeout=30s;
    server app02:8080 max_fails=3 fail_timeout=30s;
}
server {
    listen 80;
    location / {
        proxy_pass http://vproapp;
        proxy_set_header Host \$http_host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }  
}
EOF

rm -rf /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp
systemctl restart nginx