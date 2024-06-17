#!/bin/bash
#
# Copyright 2022 Google Inc. All Rights Reserved.
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
#
# Startup script to add default user to workstation container.
#

groups=docker,sudo,chrome-remote-desktop
if [ ${CLOUD_WORKSTATIONS_CONFIG_DISABLE_SUDO:-false} == "true" ]
then
groups=docker,chrome-remote-desktop
fi

useradd -m user -G $groups --shell /bin/bash > /dev/null
passwd -d user >/dev/null
echo "%sudo ALL=NOPASSWD: ALL" >> /etc/sudoers

# this is a workaround for some images (e.g. intellij-gnome) not sourcing
# env vars from /etc/profile.d
runuser -c -l user whoami

