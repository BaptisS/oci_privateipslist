#!/bin/sh 
export region=$1

rm -f subnets-$region.log
rm -f pvips-$region.log
rm -f privateipslist-$region.csv

oci search resource structured-search --query-text "query subnet resources" --region $region > subnets-$region.log
subnetsocids=$(cat subnets-$region.log | jq -r '.data.items[] | ."identifier"')
for snid in $subnetsocids; do oci network private-ip list --all --subnet-id $snid --region $region >> pvips-$region.log; done
cat pvips-$region.log | jq -r '.data[] | [."subnet-id", ."id", ."display-name", ."hostname-label", ."is-primary", ."ip-address"]| @csv ' > privateipsList-$region.csv

echo "[."subnet-id", ."id", ."display-name", ."hostname-label", ."is-primary", ."ip-address"]" > privateipslist-global.csv
cat privateipsList-$region.csv >> privateipsList-global.csv

rm -f subnets-$region.log
rm -f pvips-$region.log
rm -f privateipslist-$region.csv
