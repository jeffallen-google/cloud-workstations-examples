This example installs the [Browse Lite extension](https://marketplace.visualstudio.com/items?itemName=antfu.browse-lite) which provides an embedded browser in the Code OSS IDE. Chrome browser is also installed as a dependency.

To use, start a Cloud Workstation and launch Code OSS, then type Ctrl + Shift + P to open the Command Palette and select "Browse Lite: Open...".

This example can be built with the included cloudbuild.yaml by specifying
a tag for the newly built image, such as:
```
gcloud builds submit --substitutions _TAG=us-central1-docker.pkg.dev/your-project-id/your-repository/your-image-tag
```
Optionally override the default code-oss base image by additionally specifying a \_BASE substitution, such as:
```
gcloud builds submit --substitutions _BASE=us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss-cuda:latest,_TAG=us-central1-docker.pkg.dev/your-project-id/your-repository/your-image-tag
```

