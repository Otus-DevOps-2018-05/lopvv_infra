# lopvv_infra
lopvv Infra repository

##Homework-03
#### Task \#1:
1. Create port forwarding
```
ssh -L 2202:10.132.0.3:22 lopvv@35.210.24.53
```
2. Connect to someinternalhost
```
ssh lopvv@localhost -p 2202
```

#### Task \#2:
External exercise.
1. Create file ~/.ssh/config with content:
```
Host tunnelbastion
  HostName 35.210.24.53
  IdentityFile ~/.ssh/id_rsa
  LocalForward 2202 10.132.0.3:22
  User lopvv

Host someinternalhost
  HostName localhost
  Port 2202
  User lopvv
  IdentityFile ~/.ssh/id_rsa
```
2. Create a tunnel in a background:
```
ssh -f -N tunnelbastion
```
3. Now we can use "ssh someinternalhost" to connect to remote internal host

##### Variables
bastion_IP = 35.210.24.53
someinternalhost_IP = 10.132.0.3


##Homework-04
testapp_IP = 35.204.184.40
testapp_port = 9292

1. Create and deploy
```
gcloud compute instances create reddit-app\
 --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=g1-small \
 --tags puma-server \
 --restart-on-failure \
 --metadata-from-file startup-script=startup.sh
```

2. Create Firewall rule
```
gcloud compute firewall-rules create default-puma-server \
 --allow tcp:9292 \
 --target-tags=puma-server
 ```
##Homework-05
1. Create base image with ruby and mongodb
```
packer build -var-file=./variables.json ubuntu16.json
```
2. Create full image with app
```
packer build -var-file=./variables-immutable.json immutable.json
```
3. Create instance with app from full image
```
create-reddit-vm.sh
```
