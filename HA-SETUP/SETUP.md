## SETUP

Rancher is suggesting rke based HA setup for your environments. You should need to create a file at `cluster.yaml`
### Requirements:
* Internal Ip addresses
* Private Keys !
* You have to install docker on your instances
* Ssh connected user needs to be already assign group of  <b>docker</b>

# INSTALL rancher + K8S

## Helm Setup

Cluster role binding and helm initialization
```
$ helm init
$ kubectl get po -n kube-system ## check tiller is ready ?
$ kubectl create clusterrolebinding admin-binding-helm --clusterrole cluster-admin --serviceaccount=kube-system:default || true

```

## Trusted Cert

Rancher is providing this ability for certificates which by owned by you .


```
$ kubectl -n cattle-system create secret tls tls-rancher-ingress \
  --cert=tls.crt \
  --key=tls.key

```
* Notice : If you have private CA signed certificate you shoould use this command 

```
$ kubectl -n cattle-system create secret generic tls-ca \
  --from-file=cacerts.pem
```
## Rke Installation

* Binary of rke and helm :

```
wget https://github.com/rancher/rke/releases/tag/v1.0.4
wget https://get.helm.sh/helm-v2.16.3-linux-amd64.tar.gz
```

## Rancher Installation chart

```
$ helm upgrade -i rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.super.team \
  --set ingress.tls.source=secret
```

## OFFICAL DOCS : 

https://rancher.com/docs/rancher/v2.x/en/installation/options/tls-secrets/
https://rancher.com/docs/rancher/v2.x/en/installation/k8s-install/helm-rancher/


