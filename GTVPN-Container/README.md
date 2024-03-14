## VPN-tunnel for SSH through a container

Free at last...

### First things first

You'll need to write your GT username into a file named `username`.
It, and the script `entrypoint.sh` will be copied into the image,
and upon starting a container, the script will read your username
from that file. That way you don't have to look through the script
to figure out where your username should go, and you don't end up
committing it.

### SSH config
First we're going to need an SSH key to be able to SSH into our own local container.
It sounds redundant, but SSH just doesn't allow passwordless login otherwise, and we
want a really frictionless experience.
Just create an SSH key:

```
ssh-keygen -t ed25519 -C "nosoup@foryou"
```

And be sure to store it somewhere with a name that you'll recongize later.
I just stored mine under `~/.ssh/docker`.

Then add the following to your SSH config (`~/.ssh/config`):

```
Host mydocker
	Hostname 127.0.0.1
	Port 2244
	User root
	IdentityFile ~/.ssh/docker
	IdentitiesOnly yes
	AddKeysToAgent yes
	StrictHostKeyChecking no
	UserKnownHostsFile /dev/null
```

Notice I'm pointing to the private key we just generated.

The next step is to put the public key in our container; we're just going to pack it with
the image, so just put an `authorized_keys` file in this directory, and `Dockerfile` will
copy it into root's `.ssh`:

```
echo $(cat ~/.ssh/docker.pub) >> authorized_keys
```

### Build and run the container

Building is very easy, all you need is to run the build script:

```
./build.sh
```

And you're all set.

Whenever you find yourself in need of SSHing, just go ahead and run:

```
./run.sh
```

and it will start the container, and prompt you for your VPN password, which it'll
immedietly pass down to the openconnect service, because we don't like storing passwords.
It'll also pass `push1` as the 2FA authentication method; feel free to change this in
`entrypoint.sh`, but make sure to rebuild your image with `./build.sh` whenever you make
changes to either `entrypoint.sh`, `authorized_keys` or `Dockerfile`.

Once the VPN connects, you're basically ready to seamlessly SSH without the VPN swallowing
all of your traffic.

### SSHing

For any server that requires the VPN you just set up, create an SSH config:

```
Host grumpy
	Hostname %h.gatech.edu
	User louis
	IdentityFile ~/.ssh/grumpy-key
	IdentitiesOnly yes
	AddKeysToAgent yes
	ProxyCommand ssh -W %h:%p mydocker
```

And you're literally all set!!
