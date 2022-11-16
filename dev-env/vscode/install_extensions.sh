#!/usr/bin/env bash

cat extensions | while read extension || [[ -n $extension ]];
do
  code --install-extension $extension --force
done