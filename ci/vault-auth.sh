#!/bin/bash

export VAULT_ADDRESS=http://vault.vault.svc.cluster.local:8200
vault login --method=userpass username=concourse password=password

for file in vault/app/*; do
     sh $file
done

for policy in vault/policies/*; do
    policyName=$(echo $policy | cut -d'.' -f1 | cut -d'/' -f3)
    echo $policyName
    vault policy write $policyName @$policy
done