## DEPLOYING A STATIC WEBSITE ON A PRIVATE AWS S3 BUCKET WITH CLOUDFRONT VIA IAC (TERRAFORM)  

### PREAMBLE
This is solution to class project from AltSchool live class instructor which set the following objectives.

#### Objective:
Create an AWS infrastructure to host a static website using Terraform. The infrastructure will include AWS S3 for storing the website files, CloudFront for content delivery, and Route 53 for domain name management. Additional configurations will involve setting up IAM roles and policies, API Gateway, and SSL certificates.
Prerequisites:
AWS Account
Domain name registered in Route 53
Terraform installed on your local machine

### SOLUTION

The pre-requisites were a;ready in place for the semester's grind.
So, I set out with creating the project directory and running AWS CLi command to ensure the environment is set for the grind ahead.

Using AWS configure command, I set the Access key, secret key and default AWS region.
```bash
aws configure
```
Next, I ran terraform -version to ensure terraform is running smoothly.
```bash
terraform -version
```
Next I began the 
he bash script on the Slave node and verify that the PHP application is accessible through the VM’s IP address (take screenshot of this as evidence)
2. Create a cron job to check the server’s uptime every 12 am.

Requirements

Submit the bash script and Ansible playbook to (publicly accessible) GitHub repository.

Document the steps with screenshots in md files, including proof of the application’s accessibility (screenshots taken where necessary)

Use either the VM’s IP address or a domain name as the URL.
PHP Laravel GitHub Repository: https://github.com/laravel/laravel


## SOLUTION
#### Preamble...
The following a pre-requisite to following the steps below and achieving the objective set by this exam project.
1. Bare metal; PC with Host OS (Windows in my case; windows 10 precisesly)
2. Hypervisor; a virtualization software to create the virtual machine. In my case, Oracle Virtual box (for windows) is hypervisor of choice. 
3. Command Line Terminal (both powershell and Gitbash were used for this task)

#### Step 1; Creating Virtual Machines
Created a multi-VM environment on vagrant using the code on Vagrantfile show below. For simplity, the steps acquire and install the above pre-requisites aren't detailed here. However, note that installation of those two are pre-requisite to this i

The multi-vm Vagrantfile creates two VMs, a "MASTER-NODE" and a "SLAVE-NODE". The master node has a shared folder synced, to move files between my host PC and VM.

![screenshot of a 2-VM Vagrantfile](./screenshots/multi_vm_vagrantfile.png)
Notice that as VMs are defined and named for identication and convinience. The power of vagrant.
Also noteworthy is the port forwarding and IP assignment automation made possible by vagrantfile. I used both features for the two VMs

This 2-VM enivronment appears on the hypervisor (virtualbox) as seen below...
![screenshot of a 2-VM Vagrantfile](./screenshots/vm_setup_on_vb.png)

These two VMs are provisioned with ubuntu as the linux distro of choice. which fullfils both instructions to deploy LAMP (Linux Apache MySQL PHP), and to use the Debian family of Linux,
using the following commands....
```bash
vagrant up master
```
for the master node and, 
```bash
vagrant up slave
```
for the slave node.


##
        vagrant up slave


#### Step 2; Logging into both VMs. 

With the VMs created with vagrant as shown above, the following commands were used to log in and access the VMs with ssh (vagrant has abstracted this process for us; that's the beuty of vagrant).
To log into the master, 
```bash
vagrant ssh master
```
and for the slave,
```bash
vagrant ssh slave
```
Upon login, one is greeted with the below screen..
![image of VM upon login ](./screenshots/vm_login.png)


#### Step 3; Installing ansible in the "Master Node".
The master node can also can also be called the controller node as it's just another node or server used to control other nodes (or server) which could range from one to thousands.
Ansible being a configuration management software which needs no agent to communicate to the managed nodes is required to be installed on just the master. Therefore the installation of ansible was made using the following commands.
```bash
sudo apt update
```
to update existing package repositories.
then, 
```bash
sudo apt-add-repository ppa:ansible/ansible
```
to add package repository for ansible so that latest version of ansible can be installed even when not yet added officially by ubuntu
then,
```bash
sudo apt install ansible
```
After installation, the following command was used to ensure the installation was successful and also note the version installed...
```bash
ansible --version
```
which produced result below....
![screenshot of ansible version](./screenshots/ansible_version.png)

#### Step 4. Creating a bash script on the "Master Node".
Using VScode, the file deploy_lamp.sh was created in the shared folder earlier synched (via Vagrantfile) and developed with the commands and conditionals adequate to execute the set objective of deploying a LAMP server.
The script was created in the directory
```bash
/vagrant_data/exam_project
```
The script was made executable using the following command.
```bash
    sudo chmod +x /vagrant_data/exam_project/deploy_lamp.sh
```
Then it was tested on the master node using the following commands....
```bash
   cd /vagrant_data/exam_project
```
then
```bash
    ./deploy_lamp.sh
```
This was repeated as many times as was required, editing the code until I was certain that the set objective of the script had been met, which is to automatically host the laravel

#### Step 5; Setting up Ansible Environment
The host file at /etc/amsible/hosts was updated to include the slave-node, identified by it's IP and placed in a group called [web-servers]. Connent of the hosts file as below...
##
        [web-servers]
        server1 ansible_host=192.168.56.11

        [all:vars]
        ansible_python_interpreter=/usr/bin/python3
The last line makes sure that python3 is used to run our playbook. not python 2.7.



```bash
mkdir -v code tests personal misc
```
![creating user and subdirectories](./screenshots/create_user_and_dirs.png)

#### Step 6; Preparing Ansible  playbook and performing a dry run.
tasks; 
1. run the script
2. server uptime

#### Step 7; Running the playbook  a. Change directory to the tests directory using absolute pathname
```bash
    cd /home/altschool/tests
```
![absolute path](./screenshots/cd_absolute-path.png)

#### b. Change directory to the tests directory using relative pathname. 
    ```bash
    cd ../tests
    ```
![relative path](./screenshots/cd_relative_path.png)

#### c. Use echo command to create a file named fileA with text content ‘Hello A’ in the misc directory
```bash 
echo Hello A > ./misc/fileA
```
![echo file](./screenshots/echo_file.png)

#### d. Create an empty file named fileB in the misc directory. Populate the file with a dummy content afterwards
```bash
touch ./misc/fileB
head -c 1024 /dev/urandom >>./misc/fileB
```
![empty file, dummy content](./screenshots/empty-file-dumy-content.png)

#### e. Copy contents of FileA into fileC
```bash
cp ./misc/FileA ./misc/fileC
```
![copy file](./screenshots/copy_file.png)

#### f. Move contents of fileB into fileD
```bash
mv misc/fileB misc/fileD
```
![moving file](./screenshots/move_or_rename.png)

#### g. Create a tar archive called misc.tar for the contents of misc directory 
```bash
tar -cvf misc.tar ./misc
```
![tar archive](./screenshots/tar_archiving.png)

#### h. Compress the tar archive to create a misc.tar.gz file 
```bash
gzip -kv misc.tar
```  
![gzip compression](./screenshots/gzip_compression.png)

####  i. Create a user and force the user to change his/her password upon login
```bash
sudo useradd -m altschool2
```
follow prompt for password
```bash
sudo passwd -e altschool2
```  
or this command below give the same result.
```bash
sudo chage -d 0 altschool2
```
![new user with expiring password](./screenshots/expiring_user_password.png)

#### j. Lock a users password
```bash
sudo useradd -m altschool3
```
    
```bash
sudo passwd -l  altschool3
```
![Locked password](./screenshots/locking_user_password.png)

#### k. Create a user with no login shell
```bash
sudo useradd -m -s /sbin/nologin altschoolnoshell` 
```
![crreating user with no login shell](./screenshots/no_shell_user.png)

#### l. Disable password based authentication for ssh

```bash
vi /etc/ssh/sshd_config
```
Edit the line with PasswordAuthentication from yes to no, and edit the line usePAM from yes to no, 

then saVe and run...
    `service sshd restart`
![diabaled ssh password login](./screenshots/disabled_ssh_password_login.png)

#### m. Disable root login for ssh
```bash
vi /etc/ssh/sshd_config
```
Edith or Insert the line  PermitRootLogin no under Authenntication,  
then save and run...
```bash 
    service sshd restart
```
![ssh config edit](./screenshots/disabled_root_ssh_login.png)
# S3_Static_Website_Terraform_Project
# S3_Static_Website_Terraform_Project
