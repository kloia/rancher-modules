#!/bin/bash

create_elastic_search(){

    helm init

    helm upgrade -i elasticsearch --set resources.requests.cpu=100m elastic/elasticsearch \
                --namespace logging \
                --set persistence.enabled=false \
                --set service.type=NodePort \
                --set replicas=1

}

create_elastic_search