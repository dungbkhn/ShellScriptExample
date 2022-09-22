#!/bin/bash

destipv6addr="backup@192.168.1.158"
fileprivatekey=/home/dungnt/.ssh/id_ed25519_privatekey

password="$1"
newpassword="$2"

rs=$(ssh -o PasswordAuthentication=no -o StrictHostKeyChecking=no -i "$fileprivatekey" "$destipv6addr" "echo -e '${password}\n${newpassword}\n${newpassword}' | passwd 2>&1 > /dev/null" 2>&1)

#echo $?
echo "$rs"

