#!/bin/bash
# sudo apt install jq
clear

prefix=$1

if [[ -z "$1" ]]; # or [ $# -eq 0 ]
  then
    printf "No arguments supplied \n"
    read -p "Enter Starting Prefix: "
    prefix=$REPLY
fi

printf "\n...Executing on Bash Version: ${BASH_VERSION}...\n\n"

subscription_name=$(az account show | jq ".name")
printf "Current Subscription: $subscription_name\n\n"

res_groups=$(az group list | jq '.[] | .name')
groups_to_delete=();

for g in $res_groups
do
    [[ $g =~ $prefix ]] && groups_to_delete+=( $g )
done

for to_delete in "${groups_to_delete[@]}"
do
    printf "$to_delete\n"
    # eval "az group show -n $to_delete"
    #cmd=(az group show -n $to_delete)
    #echo "${cmd[@]}"
    #"${cmd[@]}"
done

printf "\n"
read -p "Confirm deletion of above ${#groups_to_delete[@]} resource groups? (y/n):"
printf "\n"

if [[ $REPLY != "y" ]]
then
    echo "Exiting"
    exit 1
fi

for to_delete in "${groups_to_delete[@]}"
do
    printf "Deleting $to_delete\n"
    eval "az group delete -n $to_delete --no-wait -y"
    printf "\n"

done

printf "\n...Done...\n"