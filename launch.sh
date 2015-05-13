#!/bin/bash

export IMAGE=pnietoiglesias/xensb-deploy
export NAME=xensb-deploy


build(){
    echo "Build $IMAGE"
    docker build -t ${IMAGE} .
}

debug(){
   echo "Debug ${IMAGE}"
   if [ -z "$SSH_AUTH_SOCK" ] 
   then 
       eval "$(ssh-agent -s)"
       ssh-add ~/.ssh/pnieto_github
   fi
   docker run -it --rm -v $(readlink -f $SSH_AUTH_SOCK):/ssh-agent \
       -e SSH_AUTH_SOCK=/ssh-agent \
       -v /var/run/docker.sock:/var/run/docker.sock \
       ${IMAGE} /bin/bash
}

run(){
   echo "Run ${IMAGE}"
   docker kill ${NAME}
   docker rm ${NAME}
   docker run -t -i --name ${NAME} ${IMAGE}
}

usage(){
    echo "Usage: $0"
    echo "      -b: build image"
    echo "      -d: debug image with bash"
    echo "      -r: run"
    exit 1;
}

while getopts ":bhdr" opt; do
    case $opt in
        b)
            build
            exit 1
            ;;
        r)
            run
            exit 1
            ;;
        d)
            debug
            exit 1
            ;;
        h)
            usage
            exit 1
            ;;
        \?)
            usage
            exit 1
            ;;
    esac
done

usage
