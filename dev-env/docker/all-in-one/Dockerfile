FROM ubuntu:20.04
RUN apt update -y && apt upgrade -y
RUN apt -y install sudo

RUN adduser --disabled-password --gecos '' suren
RUN adduser suren sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN apt install -y wget curl vim git python3 python3-pip ansible python-apt python-pexpect

WORKDIR  /home/suren
ARG CACHEBUST=4
RUN git clone https://github.com/suren-m/devops.git 

WORKDIR  /home/suren/devops/dev-env/linux/ansible-playbooks
RUN ansible-playbook prereq.yml 
RUN ansible-playbook phase1.yml 
RUN ansible-playbook phase2.yml --tags 

USER suren



