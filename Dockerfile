FROM jenkins/jenkins:latest
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common \
       git-secrets
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli python3-pip sshpass
RUN pip3 install ansible
RUN curl -L https://github.com/quay/clair/releases/download/v4.0.2/clairctl-linux-amd64 \
  --output /usr/local/bin/clairctl
RUN chmod +x /usr/local/bin/clairctl
RUN echo '    StrictHostKeyChecking no' >> /etc/ssh/ssh_config
RUN echo '    PasswordAuthentication yes' >> /etc/ssh/ssh_config
