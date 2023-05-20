#!/bin/bash

if [ $# -lt 1 ]; then
    echo "expected an argument (build, debug, update-resources, encrypt, decrypt, update-site)"
    exit 1
fi

action=$1

if [ "$action" = "build" ]; then
    docker build -t ansible-terraform-demo .
fi

if [ "$action" = "debug" ]; then
    docker run -v "$(pwd):/app" -w "/app/" -it ansible-terraform-demo /bin/sh
fi

if [ "$action" = "update-resources" ]; then
    docker run -v "$(pwd):/app" -w "/app/" -it ansible-terraform-demo /bin/sh scripts/update_resources.sh
fi

if [ "$action" = "encrypt" ]; then
    docker run -v "$(pwd):/app" -w "/app/" -it ansible-terraform-demo /bin/sh scripts/encrypt.sh
fi

if [ "$action" = "decrypt" ]; then
    docker run -v "$(pwd):/app" -w "/app/" -it ansible-terraform-demo /bin/sh scripts/decrypt.sh
fi

if [ "$action" = "update-site" ]; then
    docker run -v "$(pwd):/app" -v "/home/$USER/.ssh/:/root/.ssh/" -w "/app/" -it ansible-terraform-demo /bin/sh scripts/update_site.sh "${@:2}"
fi

if [ "$action" = "update" ]; then
    docker run -v "$(pwd):/app" -v "/home/$USER/.ssh/:/root/.ssh/" -w "/app/" -it ansible-terraform-demo /bin/sh scripts/update.sh "${@:2}"
fi
