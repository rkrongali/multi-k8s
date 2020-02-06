docker build -t rkrongali/multi-client:latest -t rkrongali/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rkrongali/multi-server:latest -t rkrongali/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rkrongali/multi-worker:latest -t rkrongali/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rkrongali/multi-client:latest
docker push rkrongali/multi-server:latest
docker push rkrongali/multi/worker:latest

docker push rkrongali/multi-client:$SHA
docker push rkrongali/multi-server:$SHA
docker push rkrongali/multi/worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rkrongali/multi-server:$SHA
kubectl set image deployment/client-deployment client=rkrongali/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=rkrongali/multi-worker:$SHA
