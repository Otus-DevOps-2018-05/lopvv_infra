# lopvv_infra
lopvv Infra repository
====
1. Create port forwarding
ssh -L 2202:10.132.0.3:22 lopvv@35.210.24.53
2. Connect to someinternalhost
ssh lopvv@localhost -p 2202
====

====
External exercise. 
1. Create file ~/.ssh/config with content:
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

2. Create a tunnel in a background:
ssh -f -N tunnelbastion

3. Now we can use "ssh someinternalhost" to connect to remote internal host
====

bastion_IP = 35.210.24.53
someinternalhost_IP = 10.132.0.3
