FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    curl \
    unzip \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Download and install Ngrok
ENV NGROK_VERSION=3.1.1
RUN curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v${NGROK_VERSION}-linux-amd64.zip -o ngrok.zip && \
    unzip ngrok.zip && \
    mv ngrok /usr/bin/ && \
    rm ngrok.zip


# Set up SSH
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22

# Create a simple "Hello, World!" HTML page
RUN echo "<h1>Hello, World!</h1>" > /var/www/html/index.html

# Expose port 8080
EXPOSE 8080

# Copy start script
COPY start_services.sh /start_services.sh

# Start SSH and Ngrok using a script
CMD ["bash", "/start_services.sh"]
