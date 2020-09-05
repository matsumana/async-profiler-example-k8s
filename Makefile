.PHONY: all

gradlew-clean-build:
	./gradlew --no-daemon clean build

docker-build: gradlew-clean-build
	docker build -t localhost:5000/async-profiler-example-k8s:latest .

docker-push: docker-build
	docker push localhost:5000/async-profiler-example-k8s:latest

kubectl-create-example:
	kubectl apply -f manifests/example.yml

kubectl-delete-example:
	kubectl delete -f manifests/example.yml

kubectl-get:
	kubectl get deployment -o wide
	kubectl get svc -o wide
	kubectl get pod -o wide
