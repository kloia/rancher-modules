# Rancher Pipeline Demo

Rancher start the providing pipeline for deployment and build processes on Kubernetes based environment . This documentation is help to you about <b>How you can implement rancher pipeline on your environment ? </b>

## First Step : Create a registry

For this demo we have use the simple registry that already implemented on docker v2 . 

* You can deploy your registry with this command : 

```
 $ docker run -d -p 5000:5000 --name registry registry:2
```
### Notice : 

Docker registry need to tls termination on itself, but on your demo environment you can skip that with editing file under `/etc/docker/daemon.json` file on each worker flagged node you have . 

```
#/etc/docker/daemon.json
{
  "insecure-registries" : ["myregistrydomain.com:5000"]
}
```
## Repository Integration and Enablement

### Integration

Rancher is supporting three main SCM providers, these are Gitlab, BitBucket and Github . 

In this demo we will implement Github Integration : 
* Requirements: ClientID and ClientSecret

You can check this link how to get

https://auth0.com/docs/connections/social/github

### Enablement

Rancher Pipeline stage you need to enable repository from your Project  and then you can able to click `Run` button 


## Third Step : Implement .rancher deployment YAML file :

You can easily seperate your pipelines by stage vi YAML definiton, see that single stage implementation at below . 

```
stages:
- name: Deploy
  steps:
  - applyYamlConfig:
      path: ./new-reg.yaml

```

### Notice : 

Rancher pipeline is using Jenkins for deployment process and than if you want to make Jenkins able to deploy cluster-wide you need to set cluster-role-binding to the related service account to Jenkins : 

```
    $ kubectl create clusterrolebinding admin-binding-project --clusterrole cluster-admin --serviceaccount=p-xwtls-pipeline:jenkins || true
```