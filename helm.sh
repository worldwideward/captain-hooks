#!/bin/bash

helm lint

trivy config . -s "HIGH,CRITICAL" --exit-code 1
