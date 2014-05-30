ssh-key-import.sh
=================

Simple bash script for OS X for adding encrypted ssh private keys

# Usage

Just run ./ssh-key-import.sh and answer the question. 

Script is going to 
- set corrent permission for your private key
- generate public key
- add ssh passphrase to keychain 
- add record to .ssh/config

It's just 50 lines most of them are "echo"

