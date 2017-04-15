IMAGE_NAME = websphere-liberty-builder

build:
	@echo '---- Creating builder image -----'
	docker build . -t $(IMAGE_NAME)-candidate
	@echo '---- Creating example ----'
	s2i build . --context-dir=./example-cluster-leader $(IMAGE_NAME)-candidate cluster-leader-tester

.PHONY: test
test:
	docker run -p 9080:9080 -p 9443:9443 cluster-leader-tester
