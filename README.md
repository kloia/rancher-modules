# RANCHER MODULES
This repo is containing couple of main concept of Rancher about cluster provisioning and management level . 

### Requirements 

* Terraform v0.12.20
* ansible-playbook 2.8.1

## Authentication and Authorization : 
`auth` module is creating roles and binding them with user and projects  . If you want to enable namespace and project and you can use or develop with `namespace` module

## Ansible Playbook 

Rancher Management Server has got a api endpoints, this endpoints are containing a lots of capabilities on Rancher . Rancher API is returning docker implementation output and that setting them to the ansible task .

Command of usage : 

    * Connectivity with Rancher Server : 
    ```
        $ chmod +x main.sh && ./main.sh ## You need to set your username and password
    ```

    * Provisioning Level 

    ```
        $ ansible-playbook -i hosts.ini -u USER site.yaml --private-key key
    ```