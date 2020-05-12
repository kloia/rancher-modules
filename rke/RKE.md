# RKE Based Installation

Rancher locates management-server in a cluster that already provisioned by RKE tools. Rke is an engine for install Kubernetes easily.

If you need to follow this setup you should need to install those requirements :

* Helm (2.16 + above)
* Kubectl
* rke tools

## Steps of installation 

### Management Cluster

You need a `cluster.config` yaml that contains nodes by roles, those nodes should be member of <b>control-plane</b> r <b>worker</b>.

Setup a cluster like that : 

```
  $ rke up --config cluster.yaml ##rke version v1.0.0
```

### Helm Based Installation

After you have complete the setup of <b>management cluster</b> successfully, you install rancher application with helm.

`$ helm repo add rancher-latest https://releases.rancher.com/server-charts/latest`

```
$ helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.my.org --set tls=external
```

### Binary addresses of required cli for RKE Based Setup:

* Helm: https://get.helm.sh/helm-v2.16.7-linux-amd64.tar.gz
* RKE:  https://github.com/rancher/rke/releases/tag/v1.1.0

