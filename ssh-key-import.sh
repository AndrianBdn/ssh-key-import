#!/bin/sh 
RANDOM_FILE=/tmp/`uuidgen`

echo "$(tput bold)Enter server hostname:$(tput sgr0)"
read HOSTNAME 
echo "$(tput bold)Enter your user name on $HOSTNAME:$(tput sgr0)"
read USERNAME

echo "$(tput bold)Paste your encrypted private key for $HOSTNAME and press Ctrl-D$(tput sgr0)"
cat > $RANDOM_FILE 

echo "Generating public key... we are goint to ask you for $(tput bold)passphrase$(tput sgr0)"
chmod 600 $RANDOM_FILE
ssh-keygen -y -f $RANDOM_FILE >> $RANDOM_FILE.pub
echo "Created $RANDOM_FILE.pub"
echo

echo 
echo "Moving private-key to new place"
SSH_PRIVATE_KEY="$HOME/.ssh/$USERNAME-$HOSTNAME"

mv $RANDOM_FILE $SSH_PRIVATE_KEY
mv $RANDOM_FILE.pub "$SSH_PRIVATE_KEY.pub"

echo 
echo "Adding to key chain, $(tput bold)enter passphrase again$(tput sgr0)"
ssh-add -K $SSH_PRIVATE_KEY

echo "Generating .ssh/config"
echo "$(tput bold)Enter server short name for: ssh <shortname>$(tput sgr0)"
read SHORTNAME

SSHCONFIG="Host $SHORTNAME\n"
SSHCONFIG="$SSHCONFIG User $USERNAME\n"
SSHCONFIG="$SSHCONFIG HostName $HOSTNAME\n"
SSHCONFIG="$SSHCONFIG IdentityFile $SSH_PRIVATE_KEY\n"

echo $SSHCONFIG

read -p "$(tput bold)Add this to your .ssh/config?$(tput sgr0)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo >> $HOME/.ssh/config
    echo $SSHCONFIG >> $HOME/.ssh/config
    echo 
    echo "$(tput bold)Awesome!$(tput sgr0)"
    echo "You may now type $(tput bold)ssh $SHORTNAME$(tput sgr0) to login to the server"
fi
