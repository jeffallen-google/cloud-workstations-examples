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

# default cloud workstations image
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

# apply update
RUN apt-get update && apt-get upgrade -y

# install minimal desktop with dependencies, then disable 1st time wizard and ubuntu update popups
RUN apt-get install -y gnome-software gnome-software-common gnome-software-plugin-snap libappstream-glib8 libgd3 colord gnome-control-center gvfs-backends hplip libgphoto2-6 libsane sane-utils ubuntu-desktop-minimal && \
#  apt-get remove -y gnome-initial-setup && \
#  apt-get install -y libgd3 && \
#  apt-get install -y colord gnome-control-center gvfs-backends hplip libgphoto2-6 libsane sane-utils ubuntu-desktop-minimal && \
  apt-get remove -y gnome-initial-setup && \
  chmod -x /usr/lib/ubuntu-release-upgrader/check-new-release-gtk

# disable pulseaudio which will be initialized instead in CRD session
RUN rm /etc/systemd/user/sockets.target.wants/pulseaudio.socket && \
  rm /etc/systemd/user/default.target.wants/pulseaudio.service

# install packages:
# - chrome remote desktop from downloaded deb file
# - locales to suppress pam_env warning about missing /etc/default/locale

RUN wget -O /tmp/crd.deb https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && \
  apt-get install -y /tmp/crd.deb locales && \
  rm /tmp/crd.deb && \
  ln -s /lib/systemd/system/chrome-remote-desktop@.service /etc/systemd/system/multi-user.target.wants/chrome-remote-desktop@user.service && \
  sed -i '/\[Unit]/a ConditionPathExists=/home/%I/.config/chrome-remote-desktop' /lib/systemd/system/chrome-remote-desktop@.service
COPY files/chrome-remote-desktop-session /etc/

# modify user creation script to add user to chrome-remote-desktop group
COPY files/010_add-user.sh /etc/workstation-startup.d/

# suppress polkit reauth dialogs
COPY files/10-chrome-remote-desktop.pkla /etc/polkit-1/localauthority/50-local.d/

# create systemd service wrapper for existing cloud workstations entrypoint script
# and unlink systemd units:
# - module load unit which will fail and cause systemctl to show degraded (but otherwise doesn't seem to cause problems)
# - ssh service because ssh is already handled by workstation-startip.d
COPY files/prepare-environment.service files/entrypoint.service files/wait-for-user-user.service /lib/systemd/system/
COPY files/prepare-environment.sh files/wait-for-user.sh /google/scripts/
RUN ln -s /lib/systemd/system/entrypoint.service /etc/systemd/system/multi-user.target.wants/ && \
  ln -s /lib/systemd/system/wait-for-user-user.service /etc/systemd/system/multi-user.target.wants/ && \
  ln -s /lib/systemd/system/prepare-environment.service /etc/systemd/system/multi-user.target.wants/ && \
  rm /lib/systemd/system/sysinit.target.wants/systemd-modules-load.service && \
  rm /etc/systemd/system/multi-user.target.wants/ssh.service;

# reconfigure to launch wrapdocker through systemd
COPY files/wrapdocker.service /lib/systemd/system/
RUN rm /etc/workstation-startup.d/000_configure-docker.sh && \
  rm /etc/systemd/system/multi-user.target.wants/containerd.service && \
  rm /etc/systemd/system/multi-user.target.wants/docker.service && \
  rm /etc/systemd/system/sockets.target.wants/docker.socket && \
  ln -s /lib/systemd/system/wrapdocker.service /etc/systemd/system/multi-user.target.wants/ && \
  sed -i 's/service docker start .*/exit/' /google/scripts/wrapdocker/wrapdocker

# install chrome browser - this is not required but provides and example of customizing software and UI menus
# also adjust quick launch favorites and patch desktop file
COPY files/20_cloud-workstations-settings.gschema.override /usr/share/glib-2.0/schemas/
RUN wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  apt-get install -y /tmp/chrome.deb && \
  rm /tmp/chrome.deb && \
  glib-compile-schemas /usr/share/glib-2.0/schemas/ && \
  sed -i 's/\/usr\/bin\/google-chrome-stable/\/usr\/bin\/google-chrome-stable --disable-dev-shm-usage/g' /usr/share/applications/google-chrome.desktop

# oddly, apache2 is now installed in the base image
# but it isn't being used, so we'll disable it here
# to avoid interfering with the code oss server on port 80
RUN rm /etc/systemd/system/multi-user.target.wants/apache2.service

ENTRYPOINT ["sh", "-c"]
CMD ["until journalctl -f; do sleep 1; done & exec /sbin/init --system --unit=multi-user.target"]

