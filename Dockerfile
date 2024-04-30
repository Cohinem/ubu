FROM ubuntu:20.04

# Install required packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Download and install Ngrok
ENV NGROK_VERSION=3.1.1
RUN curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v${NGROK_VERSION}-linux-amd64.zip -o ngrok.zip && \
    unzip ngrok.zip && \
    mv ngrok /usr/bin/ && \
    rm ngrok.zip

# Set Ngrok authtoken
ENV NGROK_AUTHTOKEN=25JHgJ9StsG1BPntaNaz8l906wk_5JULzxuQxb8BMjErRpavu

# Set up SSH
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22

# Start SSH and Ngrok
CMD service ssh start && \
    ngrok authtoken $NGROK_AUTHTOKEN && \
    ngrok tcp 22 && \
    tail -f /dev/null
