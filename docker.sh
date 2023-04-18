#!/bin/bash

docker build .

trivy config . -s "HIGH,CRITICAL" --exit-code 1
