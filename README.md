# vagrant-latex

Write text with LaTeX within a VM. Build this VM with vagrant.

## Overview

The main purpose is to write my master thesis.

This VM is based on Ubuntu 16.04 LTS and includes the following Tools:
* XFCE Window Manager
* Full TeX Live distribution
* Python Pygments for syntax highlighting
* TeXstudio
* Jabref
* OpenJDK 8
* git
* subversion

For my personal flavor a user *martin* is created. The password field is empty
for obvious reasons. You can leave it empty and add a password after the first
login or fill it with the complete password field you find in the /etc/shadow
file.

I need a SSH key and config file copied into the VM. The necessary Lines in the
Vagrant file are commented. If you need your own credentials, copy your
*id_rsa*, *idrsa.pub* and *config* file into the data folder and uncomment the
lines in the [Vagrantfile](Vagrantfile).

For my personal use I provision german keyboard, timezone and localization. You
can adapt this to your needs or just comment it out in the vagrant file.

Finally there are some Ubuntu-VM specific fixes. You will run into some
problems with Ubuntu Linux if you don't use them.

## Building the VM

You need to do the preparation steps only once. They are the same for
all my VMs.

You have to do the provisioning once for every of my VMs.

You have to do the booting every time you want to use the VM. This
automatically updates the VirtualBox Guest Additions 

### Preparation

Install [VirtualBox](https://www.virtualbox.org/) and
[vagrant](https://www.vagrantup.com/).

Install the vagrant vbguest plugin. This is used to keep the VirtualBox Guest
Additions up to date. Open a console and enter

    $ vagrant plugin install vagrant-vbguest

On Windows you might need to use a cygwin or git console, fix your PATH
variable to find vagrant and VirtualBox. Instructions will be made as soon as
the author gets access to a windows PC.

### Run the VM

Check out the Repository. On a console, cd into the directory and run

	$ ./launch.sh

or

	> launch.bat

on windows respectively. This essentially installs the VM, reboots and then
reinstalls the VirtualBox Guest Additions, as the kernel module for the
graphical user interface won't be installed on the first run.

After the first provisioning, you start your VM with the command

	$ vagrant up

on both linux and windows.



## License

This project is licensed under the terms of the MIT license.

For more information, see [license](LICENSE.md).

