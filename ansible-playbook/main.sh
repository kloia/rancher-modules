#!/bin/bash

export PROJECT_CONFIG_FILE=rancher.yaml
export TERRAFORM_CONFIG_FILE=/tmp/config.tfvars
export YQ_CMD="yq r ${PROJECT_CONFIG_FILE}"
export RANCHER_SERVER=$(${YQ_CMD} rancher.server)
export MASTER_ROLE_FLAG=$(${YQ_CMD} rancher.master_role_flag)

get_token(){

    echo $RANCHER_SERVER
    LOGINRESPONSE=$(curl https://${RANCHER_SERVER}/v3-public/localProviders/local?action=login -H 'content-type: application/json' --data-binary '{"username":"USERNAME","password":"PASSWORD"}' --insecure)
    export LOGINTOKEN=$(echo $LOGINRESPONSE | jq -r .token)

}
generate_api_key(){

    APIRESPONSE=$(curl https://${RANCHER_SERVER}/v3/token -H 'content-type: application/json' -H "Authorization: Bearer ${LOGINTOKEN}" --data-binary '{"type":"token","description":"automation"}' --insecure)
    export APITOKEN=$(echo $APIRESPONSE | jq -r .token)
    echo $APITOKEN
}


create_k8s_cluster(){

    CLUSTERRESPONSE=$(curl -s https://${RANCHER_SERVER}/v3/cluster -H 'content-type: application/json' -H "Authorization: Bearer ${APITOKEN}" -d @cluster/config.json --insecure)
    export CLUSTERID=$(echo ${CLUSTERRESPONSE} | jq -r .id)

}

generate_master_output(){

    GENERATED_TOKEN=$(curl -s https://${RANCHER_SERVER}/v3/clusterregistrationtoken -H 'content-type: application/json' -H "Authorization: Bearer ${APITOKEN}" --data-binary '{"type":"clusterRegistrationToken","clusterId":"'$CLUSTERID'"}' --insecure)

    ROLEFLAGS="${MASTER_ROLE_FLAG}"

    AGENTCMD=$(curl -s https://${RANCHER_SERVER}/v3/clusterregistrationtoken?id=${CLUSTERID} -H 'content-type: application/json' -H "Authorization: Bearer ${APITOKEN}" --insecure | jq -r '.data[].nodeCommand' | head -1)

    echo "         $AGENTCMD $ROLEFLAGS" >> basic-cluster/roles/masters/tasks/main.yaml

}

generate_worker_output(){

    GENERATED_TOKEN=$(curl -s https://${RANCHER_SERVER}/v3/clusterregistrationtoken -H 'content-type: application/json' -H "Authorization: Bearer ${APITOKEN}" --data-binary '{"type":"clusterRegistrationToken","clusterId":"'$CLUSTERID'"}' --insecure)

    ROLEFLAGS="--worker"

    AGENTCMD=$(curl -s https://${RANCHER_SERVER}/v3/clusterregistrationtoken?id=${CLUSTERID} -H 'content-type: application/json' -H "Authorization: Bearer ${APITOKEN}" --insecure | jq -r '.data[].nodeCommand' | head -1)

    echo "         $AGENTCMD $ROLEFLAGS" >> basic-cluster/roles/workers/tasks/main.yaml

}

update_cluster(){

    CLUSTERRESPONSE=$(curl -s https://${RANCHER_SERVER}/v3/cluster/${CLUSTERID} -H 'content-type: application/json' -H "Authorization: Bearer ${APITOKEN}" -d @cluster/config.json --insecure -XPUT)
    echo $CLUSTERRESPONSE
}

get_token
generate_api_key
create_k8s_cluster
generate_master_output
generate_worker_output
#update_cluster