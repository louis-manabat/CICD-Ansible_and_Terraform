#!/bin/bash
set +ex

## Hacky way to build inventory file
echo "all:" > inventory.yml
echo "  hosts:" >> inventory.yml

