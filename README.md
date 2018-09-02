# lopvv_infra
lopvv Infra repository

## Homework-03
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


## Homework-04


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

 ##### Variables

 testapp_IP = 35.204.184.40

 testapp_port = 9292
## Homework-05
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

## Homework-06
#### Задание со \*
Добавил файл metadata.tf

Если добавить еще один ключ вручную, то после выполнения terraform apply он затирается.


#### Задание с \*\*
Попробую разобраться позже, после остальных дз.


## Homework-07
С помощью packer разбил базовый образ на два: app и db

Создал отдельные модули для app и db

Создал правила файервола и вынес в модуль VPC

Создал два окружения stage и prod

Создал в хранилище gcp бакеты для бэкэнда


#### Задание со \* 1

Создал удаленный бэкэнд backend.tf

Необходимо выполнить terraform init в директориях prod и stage

#### Задание со \* 2

Добавил provisioner в модуль приложения для деплоя.

Также добавил provisioner в модуль БД для прослушивания не только локалхоста.


## Homework-08
Если выполнить

```
ansible-playbook clone.yml
```
А затем
```
ansible app -m command -a 'rm -rf ~/reddit'
```
И снова
```
ansible-playbook clone.yml
```
То результат будет отличаться, потому что в первый раз изменений не было (changed=0). Репозиторий уже существовал.
А во второй раз изменения были, ведь мы удалили репозиторий. (changed=1)


#### Задание со \*
Для динамического инвентори добавил скрипт inventory.py. Необходимые для его работы пакеты добавил в requirements.txt
Пример команды для запуска:
```
ansible all -i ./inventory.py -m ping
```

Для формирования актуального инвентори в формате json необходимо выполнить:
```
./inventory.py --list > inventory.json
```

## Homework-09
Познакомился с использованием плейбуков, хендлеров и шаблонов.

Рассмотрел разные подходы:
- один плейбук, один сценарий
- один плейбук, много сценариев
- много плейбуков

Изменил провижн пакер образов на ansible плейбуки

#### Задание со \*

Настроил в качестве dynamic inventory gce.py.
Настройки подключения к GCP находятся в gce.ini.

Указал использовать его в ansible.cfg.
В app.yml переменная db_host подтягивается из gce.py
```
   db_host: "{{ hostvars['reddit-db']['gce_private_ip'] }}"
```
Таким образом ручное добавление ip адресов исключено полностью


## Homework-10
Создал раздельные роли для app и db.
Описал окружения prod и stage.
Настроил использование коммьюнити роли jdauphant.nginx на app.
Познакомился с работой Ansible Vault

#### Задание со \*

Донастроил в качестве dynamic inventory gce.py.
В том числе указал переменные в group_vars через переменные динамического инвентори.
Настройки подключения к GCP находятся в gce.ini.

Указал использовать его в ansible.cfg.
