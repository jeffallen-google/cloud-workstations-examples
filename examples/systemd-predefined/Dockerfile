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

# patch docker scripts to run dockerd directly
RUN sed -i 's/\(^service docker start.*\)/#\1\n\/usr\/bin\/dockerd $DOCKER_OPTS /' /google/scripts/wrapdocker/wrapdocker && \
  sed -i 's/\(^\s*\)\(sudo service docker restart\)/\1#\2\n\1DOCKERD_PID=$(\/usr\/bin\/dockerd) \&\& sudo kill $DOCKERD_PID\n\1sudo \/usr\/bin\/dockerd $DOCKER_OPTS /' /etc/workstation-startup.d/000_configure-docker.sh

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      systemd \
      && \
    apt-get clean && \
    rm -rf /apt-keys && \
    rm -rf /var/lib/apt/lists/*

# Merge in files from the assets directory
COPY ./assets/. /

ENTRYPOINT ["/usr/bin/workstation-init"]

