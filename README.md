# oci_privateipslist




`````
#!/bin/sh 
rm -f listips.sh
rm -f privateipsList-global.csv

wget https://raw.githubusercontent.com/BaptisS/oci_privateipslist/main/listips.sh
chmod +x listips.sh

regionslist=$(oci iam region list)
regions=$(echo $regionslist | jq -r '.data[] | ."name"')
for region in $regions; do ./listips.sh $region && echo "Collecting IP addresses assigned in" $region ; done
rm -f listips.sh
cat privateipsList-global.csv
echo "File : privateipsList-global.csv"
`````

