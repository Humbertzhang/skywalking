#!/usr/bin/env bash

# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# ----------------------------------------------------------------------------

set -ex

HELMVERSION=${HELMVERSION:-'helm-v3.0.0'}
K8SVERSION=${K8SVERSION:-'k8s-v1.19.2'}
KINDVERSION=${KINDVERSION:-'v0.10.0'}
SWCTLVERSION=${SWCTLVERSION:-'0.6.0'}

curl -Lo ./e2e https://github.com/Humbertzhang/nge2etest/releases/download/test0.1/e2e
chmod +x ./e2e
sudo mv ./e2e /usr/local/bin/e2e

curl -Lo ./kind https://kind.sigs.k8s.io/dl/${KINDVERSION}/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

curl -sSL https://get.helm.sh/${HELMVERSION}-linux-amd64.tar.gz | \
    sudo tar xz -C /usr/local/bin --strip-components=1 linux-amd64/helm

curl -sSL "https://storage.googleapis.com/kubernetes-release/release/${K8SVERSION#k8s-}/bin/linux/amd64/kubectl" -o /tmp/kubectl
chmod +x /tmp/kubectl
sudo mv /tmp/kubectl /usr/local/bin/kubectl
mkdir ~/.kube

curl -sSL https://mirrors.bfsu.edu.cn/apache/skywalking/cli/${SWCTLVERSION}/skywalking-cli-${SWCTLVERSION}-bin.tgz -o swctl.tgz
tar -zxvf swctl.tgz
chmod +x skywalking-cli-${SWCTLVERSION}-bin/bin/swctl-${SWCTLVERSION}-linux-amd64
sudo mv skywalking-cli-${SWCTLVERSION}-bin/bin/swctl-${SWCTLVERSION}-linux-amd64 /usr/local/bin/swctl
