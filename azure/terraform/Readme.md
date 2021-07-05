# Azure environment provisioned using Terraform


## Symlinking (only if required)

If `terraform` plays up with relative paths on module sources, then either move modules to a separate github source or use symlinks and update the source path to same directory as templates `.` For more, [see here](https://stackoverflow.com/a/18791647) and [here](https://github.com/hashicorp/terraform/issues/23333)

