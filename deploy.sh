docker build -t alexeykirinyuk/multi-client:latest -t alexeykirinyuk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexeykirinyuk/multi-server:latest -t alexeykirinyuk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexeykirinyuk/multi-worker:latest -t alexeykirinyuk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexeykirinyuk/multi-client:latest
docker push alexeykirinyuk/multi-server:latest
docker push alexeykirinyuk/multi-worker:latest

docker push alexeykirinyuk/multi-client:$SHA
docker push alexeykirinyuk/multi-server:$SHA
docker push alexeykirinyuk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=alexeykirinyuk/multi-client:$SHA
kubectl set image deployments/server-deployment server=alexeykirinyuk/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=alexeykirinyuk/multi-worker:$SHA