#!/bin/bash

# Copyright 2023 Google Inc. All Rights Reserved.
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

EXCLUDE='HOME|HOSTNAME|GOOGLE_CLOUD_WORKSTATIONS|PATH|DEBIAN_FRONTEND|PWD'
OUTPUT=/etc/profile.d/00-workstation-environment.sh

</proc/1/environ tr '\0' '\n' | \
  grep -vP "^($EXCLUDE)=" | \
  sed 's/'"'"'/'"'"'"'"'"'"'"'"'/' | \
  sed -e 's/^/export '"'"'/' | \
  sed -e 's/$/'"'"'/' \
  >$OUTPUT

# make DOCKER_OPTS available to wrapdocker.service in systemd
. $OUTPUT
printf -- "export 'DOCKER_OPTS=$(printf -- "$DOCKER_OPTS"|sed 's/'"'"'/'"'"'"'"'"'"'"'"'/')'\n" >/google/scripts/wrapdocker/wrapdocker.env

