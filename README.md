# oci_privateipslist




`````
#!/bin/sh 
rm -f privateipsList-global.csv
regionslist=$(oci iam region list)
regions=$(echo $regionslist | jq -r '.data[] | ."name"')
for region in $regions; do ./listips.sh $region && echo "Collecting IP addresses assigned in" $region ; done
`````

