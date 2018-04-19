#!/usr/bin/env bash
main(){
    reset_helm
    reset_ns
}

reset_helm(){
    echo "reset_helm"
    helm list | grep --color=none chart-api-service-demo | cut -f1 | xargs helm delete  --purge
}

reset_ns(){

    echo "reset_ns"
    recreate_ns "staging"
    recreate_ns "released"
    sleep 5
    kubectl get ns

}

recreate_ns(){
 name=$1
 echo "Deleting Namespace $name"
 delete=true
 while ! (kubectl get ns $name 2>&1 | grep -q "NotFound");do
 if [ "$delete" = true ]; then delete=false; kubectl delete ns $name; fi
    echo -n "."
    sleep 5;
 done
 echo -e "\nCreating Namespace $name"
 kubectl create ns $name
}

main