#!/bin/sh
# Tested Cgywin, Ubuntu, Debian
# create ssh connections without giving a password - found on the net
# Modified by DHJ to correct several bugs and missing commands

if [ $# -lt 1 ]; then
echo Usage: $0 username@remotehost
exit
fi
remote="$1" # 1st command-line argument is the user@remotehost address
this=$HOST # name of client host

# first check if we need to run ssh-keygen for generating
# $HOME/.ssh with public and private keys:
if [ ! -d $HOME/.ssh ]; then
echo "just type RETURN for each question:" # no passphrase - unsecure!!
# generate DSA keys only:
echo; echo; echo
#This will generate the .ssh directory and put the keys in it
ssh-keygen -t dsa
else
# we have $HOME/.ssh, but check that we have
# key (DSA):
if [ ! -f $HOME/.ssh/id_dsa ]; then
# generate DSA keys:
echo "just type RETURN for each question:" # no passphrase - unsecure!!
ssh-keygen -t dsa
fi
fi

echo "You will be asked for your remote password several times during this phase"

cd $HOME/.ssh

if [ ! -f config ]; then
# make ssh try ssh -2 (DSA keys)
echo "Protocol 2" > config
chmod 600 config
fi

#Make sure private key cannot be read by anyone else
chmod 600 $HOME/.ssh/id_dsa

# copy public keys to the destination host:

echo; echo; echo
# create .ssh on remote host if it's not there:
echo "Connecting to remote host to create .ssh directory..."
ssh $remote 'if [ ! -d .ssh ]; then mkdir .ssh; fi'
# copy DSA key:
echo "Copying public DSA key to remote host..."
scp id_dsa.pub ${remote}:.ssh/${this}_dsa.pub
# make authorized_keys(2) files on remote host:

echo; echo; echo
# this one copies DSA key:
echo "Configuring authorized_keys2 file on remote host..."
ssh $remote "cd .ssh; touch authorized_keys2; cat ${this}_dsa.pub >> authorized_keys2;"
echo "Configuring directory permissions on remote host..."
ssh $remote "cd .ssh; rm ${this}_dsa.pub; chmod 600 *; cd ..; chmod go-rwx .ssh;"
echo; echo; echo
echo "You should now be able to ssh to the remote host without a password"
echo "try ssh $remote"
