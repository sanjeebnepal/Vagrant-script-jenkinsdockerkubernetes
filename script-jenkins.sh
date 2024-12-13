#!/bin/bash

### Dependent Package installation 
apt-get update
apt-get install -y fontconfig openjdk-17-jre zip

### Adding new package repository to install Jenkins
wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

apt-get update
apt-get install -y jenkins
systemctl restart jenkins

### Removing exiting user config files
rm -rf /var/lib/jenkins/users

### Copying all local config files to Jenkins VM
cp -r jenkins-config/* /var/lib/jenkins/

chown -R jenkins:jenkins /var/lib/jenkins
systemctl restart jenkins

### Updating Jenkins URL with VM's IP address
ip=$(ip -f inet addr show eth1 | grep -Po 'inet \K[\d.]+')
sed -i "s/VM_IP/$ip/g" /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml

### Updating Jenkins version
version=$(jenkins --version)
sed -i "s/JENKINS_VERSION/$version/g" /var/lib/jenkins/jenkins.install.UpgradeWizard.state
sed -i "s/JENKINS_VERSION/$version/g" /var/lib/jenkins/jenkins.install.InstallUtil.lastExecVersion

### Downloading Jenkins cli file
if [ ! -f jenkins-cli.jar ]; then
    wget http://localhost:8080/jnlpJars/jenkins-cli.jar
fi

### Installing Jenkins plugins using username and password
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:admin123 install-plugin docker-workflow git workflow-multibranch multibranch-scan-webhook-trigger github ssh-agent ssh-slaves timestamper email-ext build-timeout workflow-aggregator pipeline-stage-view ant github-branch-source nodejs pipeline-github-lib matrix-auth antisamy-markup-formatter gradle pam-auth ws-cleanup ldap cloudbees-folder kubernetes-cli

systemctl restart jenkins

echo "jenkins ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers


###docker
apt update -y
apt install gnome-terminal -y

apt-get update -y
apt-get install ca-certificates curl -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y

apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

#to avoid using sudo with every docker commands
groupadd docker
usermod -aG docker $USER
newgrp docker

