## SETUP


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
