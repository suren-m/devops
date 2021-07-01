printf "\nkubectl get nodes -L agentpool -L pool -L workload\n"
kubectl get nodes -L agentpool -L pool -L workload
printf "\nkubectl get po -o wide -n webapp-pool1 \n"
kubectl get po -o wide -n webapp-pool1
printf "\nkubectl get po -o wide -n redis-pool1 \n"
kubectl get po -o wide -n redis-pool1
printf "\nkubectl get po -o wide  -n webapp-pool2 \n"
kubectl get po -o wide  -n webapp-pool2
printf "\nkubectl get po -o wide  -n redis-pool2 \n"
kubectl get po -o wide  -n redis-pool2
printf "\nkubectl get po -o wide -n kube-system | grep -E 'NAME|core|metrics' \n"
kubectl get po -o wide -n kube-system | grep -E 'NAME|core|metrics'
printf "\n"