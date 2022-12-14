#! /bin/sh 
# listppa Script to get all the PPA installed on a system ready to share for reininstall
# When you call it with listppa > installppa.sh you get a script you can copy on a new machine to reinstall all PPA.
for APT in `find /etc/apt/ -name \*.list`; do
    grep -o "^deb http://ppa.launchpad.net/[a-z0-9\-]\+/[a-z0-9\-]\+" $APT | while read ENTRY ; do
        USER=`echo $ENTRY | cut -d/ -f4`
        PPA=`echo $ENTRY | cut -d/ -f5`
        echo sudo apt-add-repository ppa:$USER/$PPA
    done
done
