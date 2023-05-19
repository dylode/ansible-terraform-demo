FROM python:alpine3.18

RUN apk update && apk add --no-cache openssh-client fzf jq openssl ca-certificates && update-ca-certificates

RUN pip install yq ansible

COPY requirements.yaml .

RUN ansible-galaxy collection install -r requirements.yaml

RUN wget https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip && \
    unzip terraform_1.4.6_linux_amd64.zip && \
    mv terraform /usr/bin/terraform