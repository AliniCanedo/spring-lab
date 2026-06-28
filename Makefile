.PHONY: help build test run clean \
docker-build docker-run docker-stop \
kind-load k8s-apply k8s-delete \
helm-lint helm-template helm-install helm-uninstall

help:
	@echo "===== Spring Lab ====="
	@echo ""
	@echo "Application"
	@echo "  make build"
	@echo "  make test"
	@echo "  make run"
	@echo "  make clean"
	@echo ""
	@echo "Docker"
	@echo "  make docker-build"
	@echo "  make docker-run"
	@echo "  make docker-stop"
	@echo ""
	@echo "Kind / Kubernetes"
	@echo "  make kind-load"
	@echo "  make k8s-apply"
	@echo "  make k8s-delete"
	@echo ""
	@echo "Helm"
	@echo "  make helm-lint"
	@echo "  make helm-template"
	@echo "  make helm-install"
	@echo "  make helm-uninstall"

build:
	./mvnw clean package

test:
	./mvnw test

run:
	./mvnw spring-boot:run

clean:
	./mvnw clean

docker-build:
	docker build -t spring-lab:v1 .

docker-run:
	docker compose up -d

docker-stop:
	docker compose down

kind-load:
	kind load docker-image spring-lab:v1

k8s-apply:
	kubectl apply -f k8s/

k8s-delete:
	kubectl delete -f k8s/

helm-lint:
	helm lint helm/spring-chart

helm-template:
	helm template spring helm/spring-chart

helm-install:
	helm upgrade --install spring helm/spring-chart

helm-uninstall:
	helm uninstall spring