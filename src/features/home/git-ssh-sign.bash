#!/bin/bash

# This script is a wrapper around ssh-keygen that
# ensures that the signing key is added to the ssh-agent on use.

signing_key=""
sign=false
args=("$@")

while [[ -n "$1" ]]; do
    case "$1" in
    "-f")
        signing_key="${2%.pub}"
        ;;
    "-Y")
        if [[ "$2" == "sign" ]]; then
            sign=true
        fi
        ;;
    esac
    shift
done

if [[ -z "$signing_key" ]]; then
    echo "signing_key was empty" >&2
    exit 1
fi

if [[ $sign == false ]]; then
    exec ssh-keygen "${args[@]}"
fi

ssh-add -l | grep -q "$(ssh-keygen -lf "$signing_key" | awk '{print $2}')" || ssh-add -q "$signing_key" || exit

exec ssh-keygen "${args[@]}"
