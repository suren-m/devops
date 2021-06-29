# Azure environment provisioned using Terraform

## Sym-link modules and files directory since terraform can play up if relative paths were provided as module sources

### From az-base and az-env

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
```

For more, [see here](https://stackoverflow.com/a/18791647) and [here](https://github.com/hashicorp/terraform/issues/23333)

---
