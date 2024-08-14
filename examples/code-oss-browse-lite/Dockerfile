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

# install browse-lite vode-oss extension and chrome browser
RUN EXT_VERSION=0.3.9 && \
  DEB_FILE=google-chrome-stable_current_amd64.deb && \
  wget https://open-vsx.org/api/antfu/browse-lite/$EXT_VERSION/file/antfu.browse-lite-$EXT_VERSION.vsix && \
  unzip antfu.browse-lite-$EXT_VERSION.vsix "extension/*" && \
  mv extension /opt/code-oss/extensions/antfu.browse-lite && \
  rm antfu.browse-lite-$EXT_VERSION.vsix && \
  wget https://dl.google.com/linux/direct/$DEB_FILE && \
  apt-get update && \
  apt-get install -y ./$DEB_FILE && \
  rm $DEB_FILE && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Merge in files from the assets directory
COPY ./assets/. /

