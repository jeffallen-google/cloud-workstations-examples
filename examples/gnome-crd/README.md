# Description

This example adds Gnome and Chrome Remote Desktop to the predefined code-oss image.

## Instructions

Use your tool of choice to build and tag the image for use with your Cloud Workstations configuration, such as:

```
gcloud builds submit -t [ARTIFACT REGISTRY TAG GOES HERE]
```

The first time you launch a new workstation based on this example, use the Code OSS terminal or SSH to [initialize Chrome Remote Desktop on the command line](https://remotedesktop.google.com/headless). After first-time initialization, the next time you start the same workstation, Chrome Remote Desktop should start automatically.

