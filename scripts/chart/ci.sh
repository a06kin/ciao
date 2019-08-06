#!/usr/bin/env bash

set -e

self=${0##*/}
dependencies=helm,mc

echo "== $self"

# Check dependencies
for d in $(echo $dependencies | tr "," "\n"); do
  command -v $d >/dev/null 2>&1 || { echo >&2 "== $self requires $d but it's not installed."; exit 1; }
done

CHART_NAME=ciao
CHART_HELM_REPO=https://releases.brotandgames.com/helm-charts

cd $(dirname $0)/..

rm -rf /tmp/chart
mkdir -p /tmp/chart/
cp -Rf ../chart /tmp/chart/$CHART_NAME

echo "== $self Chart validate"
helm lint /tmp/chart/$CHART_NAME

echo "== $self Chart package"
helm package -d /tmp/chart /tmp/chart/$CHART_NAME
