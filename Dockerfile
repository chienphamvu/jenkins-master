FROM jenkins/jenkins:lts

USER root

ARG TERRAFORM_VERSION=0.12.3

EXPOSE 8080
EXPOSE 50000

RUN apt-get update && \
	apt-get install -y jq

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install plugins
RUN /bin/bash -x -c "/usr/local/bin/install-plugins.sh swarm nodelabelparameter github ws-cleanup"

USER jenkins
VOLUME /home/jenkins
