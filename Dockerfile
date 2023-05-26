FROM python:alpine3.18

ARG USER_ID
ARG GROUP_ID

RUN apk update && apk add --no-cache openssh-client fzf jq openssl ca-certificates && update-ca-certificates

RUN pip install yq ansible

RUN wget https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip && \
    unzip terraform_1.4.6_linux_amd64.zip && \
    mv terraform /usr/bin/terraform


#RUN deluser $(getent passwd $USER_ID | cut -d ':' -f 1)

#RUN adduser --disabled-password --gecos '' --uid $USER_ID user

RUN adduser --disabled-password --gecos '' --uid $USER_ID user
# RUN addgroup user usergroup && addgroup user root
#RUN addgroup --gid $GROUP_ID usergroup

USER user

COPY requirements.yaml .

RUN ansible-galaxy collection install -r requirements.yaml