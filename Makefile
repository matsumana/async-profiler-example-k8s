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

start-profiling:
	kubectl exec -it $$(kubectl get pods | grep example- | awk '{print $$1}') -- bash -c '/async-profiler/async-profiler-*-linux-x64/profiler.sh -d 30 -f /tmp/cpu_profile.svg 1'

copy-profile_svg:
	kubectl cp $$(kubectl get pods | grep example- | awk '{print $$1}'):/tmp/cpu_profile.svg ./cpu_profile.svg

kubectl-get:
	kubectl get deployment -o wide
	kubectl get svc -o wide
	kubectl get pod -o wide
