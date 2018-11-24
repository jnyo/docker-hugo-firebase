#!/usr/bin/env bash

hugoVersions=$1

docker build -f hugo/${hugoVersions}/Dockerfile -t jnyo/docker-hugo-firebase:latest -t jnyo/docker-hugo-firebase:${hugoVersions} .
