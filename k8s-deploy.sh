echo '---------------------------'
echo '=====>deploy fdic-api<====='
echo '---------------------------'

echo '=====>build fdic-api<====='
docker build --no-cache -t fdic-api .

echo '=====>tag fdic-api<====='
docker tag fdic-api:latest registry.ng.bluemix.net/remkohdev-ns/fdic-api:latest

echo '=====>login to registry<====='
# make sure you are logged in before you run this script
# ibmcloud login -a https://api.ng.bluemix.net
# ibmcloud cs region-set us-south
# ibmcloud cs cluster-config ibmcloud-cluster
# export KUBECONFIG=/...
# ibmcloud cr login

echo '=====>push fdic-api<====='
docker push registry.ng.bluemix.net/remkohdev-ns/fdic-api:latest

echo '=====>delete fdic-api-configmap'
kubectl delete configmap -n remkohdev-ns fdic-api-configmap

echo '=====>create fdic-api-configmap'
kubectl create -n remkohdev-ns -f stable/fdic-api/templates/configmap.yaml

echo '=====>delete fdic-api-deployment<====='
kubectl delete deployment -n remkohdev-ns fdic-api-deployment
# while resource still exists wait
rc=$(eval 'kubectl get deployment -n remkohdev-ns fdic-api-deployment')
while [ ! -z "$rc" ]
do
  rc=$(eval 'kubectl get deployment -n remkohdev-ns fdic-api-deployment')
done

echo '=====>create fdic-api-deployment<====='
kubectl create -f stable/fdic-api/templates/deployment.yaml

echo '=====>delete fdic-api-svc<====='
kubectl delete svc -n remkohdev-ns fdic-api-svc
# while resource still exists wait
rc=$(eval 'kubectl get svc -n remkohdev-ns fdic-api-svc')
while [ ! -z "$rc" ]
do
  rc=$(eval 'kubectl get svc -n remkohdev-ns fdic-api-svc')
done

echo '=====>create fdic-api-svc<====='
kubectl create -f stable/fdic-api/templates/service.yaml

echo '-----------------------------'
echo '=====>fdic-api deployed<====='
echo '-----------------------------'