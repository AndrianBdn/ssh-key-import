ssh-key-import.sh
=================

Simple bash script for OS X for adding encrypted ssh private keys. 

This is useful for setup when each user has different private key for different servers.


## Usage

Just run ./ssh-key-import.sh and answer the questions. 

Script is going to 
- set corrent permission for your private key
- generate public key
- put everything to .ssh 
- add ssh passphrase to keychain 
- add record to .ssh/config

It's just 50 lines most of them are "echo"

## Download 

```
curl https://raw.githubusercontent.com/AndrianBdn/ssh-key-import/master/ssh-key-import.sh >> ssh-key-import.sh && \
chmod 755 ssh-key-import.sh
```


## More 

You might need to add following lines to your ~/.ssh/config

```
# see http://serverfault.com/questions/450796/how-could-i-stop-ssh-offering-a-wrong-key
Host *
IdentitiesOnly yes
```

