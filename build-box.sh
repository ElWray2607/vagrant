#!/bin/bash

packer init -force ./packer/template.json.pkr.hcl

packer build ./packer/template.json.pkr.hcl