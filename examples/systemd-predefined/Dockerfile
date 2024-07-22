# Copyright 2024 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG BASE
FROM ${BASE}

# patch wrapdocker for systemd
RUN sed -i 's/\(^service docker start.*\)/#\1\n\/usr\/bin\/dockerd $DOCKER_OPTS /'  /google/scripts/wrapdocker/wrapdocker

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      systemd \
      && \
    apt-get clean && \
    rm -rf /apt-keys && \
    rm -rf /var/lib/apt/lists/*

# Merge in files from the assets directory
COPY ./assets/. /

# Configure systemd
RUN \
  ln -s /etc/systemd/system/save-machine-id.service /etc/systemd/system/multi-user.target.wants/ && \
  ln -s /etc/systemd/system/workstation-entrypoint.service /etc/systemd/system/multi-user.target.wants/ && \
  ln -s /dev/null /etc/systemd/system/systemd-modules-load.service && \
  ln -s /dev/null /etc/systemd/system/ssh.service && \
  ln -s /dev/null /etc/systemd/system/ssh@.service && \
  ln -s /dev/null /etc/systemd/system/ssh.socket && \
  ln -s /dev/null /etc/systemd/system/getty@ssh.service && \
  ln -s /dev/null /etc/systemd/system/getty@tty1.service && \
  ln -s /dev/null /etc/systemd/system/apache2.service && \
  ln -s /dev/null /etc/systemd/system/containerd.service && \
  ln -s /dev/null /etc/systemd/system/docker.socket && \
  ln -s /dev/null /etc/systemd/system/docker.service

ENTRYPOINT ["/usr/bin/workstation-init"]

