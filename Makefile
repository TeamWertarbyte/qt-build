# This should match the FROM line in Dockerfile:
UBUNTU := 18.04

# These override the ARG lines in Dockerfile:
QT:= 5.10.1
QTM := 5.10
QTSHA := d89ceb235e46a41240ffddd1fed558d32a27e8d10b4efa7c9b2541cc5bdb4ee6
VCS_REF := $(shell git rev-parse --short HEAD)
BUILD_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

# If you need to change anything below, please raise an issue:
TAG := qt-build:$(UBUNTU)-$(QT)

.PHONY: image

image: $(QTF)
	docker build --build-arg "QT=$(QT)" --build-arg "QTM=$(QTM)" --build-arg "QTSHA=$(QTSHA)" --build-arg "VCS_REF=$(VCS_REF)" --build-arg "BUILD_DATE=$(BUILD_DATE)" --tag "$(TAG)" .
