IMAGE = lmendelowski/devdns
TAG = latest
PLATFORMS = linux/amd64 linux/arm64

.PHONY: build push clean

build:
	@for platform in $(PLATFORMS); do \
		arch=$$(echo $$platform | cut -d/ -f2); \
		echo "Building for $$platform..."; \
		docker buildx build --platform $$platform -t $(IMAGE):$$arch --load .; \
	done

push: build
	@for platform in $(PLATFORMS); do \
		arch=$$(echo $$platform | cut -d/ -f2); \
		echo "Pushing $(IMAGE):$$arch..."; \
		docker push $(IMAGE):$$arch; \
	done
	docker manifest create --amend $(IMAGE):$(TAG) $(foreach p,$(PLATFORMS),$(IMAGE):$(shell echo $(p) | cut -d/ -f2))
	docker manifest push $(IMAGE):$(TAG)

clean:
	@for platform in $(PLATFORMS); do \
		arch=$$(echo $$platform | cut -d/ -f2); \
		docker rmi $(IMAGE):$$arch 2>/dev/null || true; \
	done
