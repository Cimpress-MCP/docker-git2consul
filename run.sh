#!/bin/sh

# Define private key if not defined
if [[ -z "$PRIVATE_KEY" ]]; then
  PRIVATE_KEY=/setup/id_rsa
fi

# Setup private key for cloning using SSH
if [[ -f $PRIVATE_KEY ]]; then
  mkdir -p $HOME/.ssh
  cp /setup/config $HOME/.ssh/config
  cp $PRIVATE_KEY $HOME/.ssh/id_rsa
  chown `id -u`:`id -u` $HOME/.ssh/*
  chmod 600 $HOME/.ssh/*
fi

# Execute whatever passed in
$@

