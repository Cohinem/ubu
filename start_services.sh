#!/bin/bash

# Start SSH
service ssh start

# Start Nginx
service nginx start

# Start Ngrok
ngrok authtoken $NGROK_AUTHTOKEN
ngrok tcp 22

# Keep the container running
tail -f /dev/null
