#!/bin/bash

# crontab -e on childcount user
# on childcount host.
#
# # reverse ssh tunnel keep-alive
# */3 * * * * /bin/bash /usr/bin/reverse_ssh

#COMMAND="ssh -N -f -R linode.mvpafrica.org:2280:localhost:22 linode.mvpafrica.org"
#ps ax |grep "$COMMAND" |grep -v "grep" > /dev/null 2>&1 || $COMMAND > /dev/null 2>&1

createTunnel() {
    export SSH_AUTH_SOCK=$1
    echo $SSH_AUTH_SOCK
    ssh -v -N -f -R port.kenyaemr.org:$2:localhost:22 -L$3:port.kenyaemr.org:22 root@port.kenyaemr.org
    if [[ $? -eq 0 ]]; then
        echo SSH tunnel created successfully
    else
        echo An error occurred creating SSH tunnel: $?
    fi
}
## Run the 'ls' command remotely.  If it returns non-zero, then create a new connection
/usr/bin/ssh -p $3 root@localhost ls
if [[ $? -ne 0 ]]; then
    echo Creating new tunnel connection using key $1 "for port" $2
    createTunnel $1 $2 $3
fi
