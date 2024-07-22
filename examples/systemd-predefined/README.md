<!--
Copyright 2024 Google Inc. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

This example explores how to adapt Cloud Workstations predefined base images to use systemd.

But why would you want systemd? Well, Cloud Workstations predefined base images include a [simplified init system](https://cloud.google.com/workstations/docs/customize-container-images#cloud-workstations-base-image-structure) which is easily extended and usually sufficient, but some image customizations may introduce dependencies on systemd.

In these situations, adaptations like the following may become useful:
- Change container entrypoint to launch systemd
- Output system logs to stdout for Cloud Logging
- Persist machine id in home directory
- Run original workstation-startup.d as systemd unit

This example can be built with the included cloudbuild.yaml by specifying
substitutions for the base image and the tag for the newly built systemd image,
such as:
```
gcloud builds submit --substitutions _BASE=us-central1-docker.pkg.dev/cloud-workstations-images/predefined/base:latest,_TAG=us-central1-docker.pkg.dev/your-project-id/your-repository/your-image-tag
```
