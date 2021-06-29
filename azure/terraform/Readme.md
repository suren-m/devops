# Azure environment provisioned using Terraform


## Symlinking

If `terraform` plays up with relative paths on module sources, then either move modules to a separate github source or use symlinks and update the source path to same directory as templates `.`

### Symlinking example - From az-base or az-env

```bash
# symlink
ln -s ../modules/ modules

# list symlinked files (will be empty)
git ls-files -s ./modules

# add them
git add ./modules

# list symlinked files again (will return object id)
git ls-files -s ./modules

# verify to see the actual path
git cat-file -p <object-id>

# Now just use source = "./modules/<name>" instead of "../modules/<name>"
```

For more, [see here](https://stackoverflow.com/a/18791647) and [here](https://github.com/hashicorp/terraform/issues/23333)


To Remove symlink 
```bash 
# check from az-env or az-base
ls -l ./modules

# output
❯ ls -l ./modules
lrwxrwxrwx 1 suren suren 11 Jun 29 21:00 ./modules -> ../modules/

# remove it if it's symlink
rm ./modules
```
---
