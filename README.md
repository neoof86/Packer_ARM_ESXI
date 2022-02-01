# Packer template for Ubuntu ARM running on VMware ESXI on ARM Hardware


This repository contains **HashiCorp Packer** templates to deploy **Ubuntu** in **VMware vSphere (with vCenter)**, using the **vsphere-iso** builder.

These templates creates the Template (or VM) directly on the vSphere server and install the latest VMware Tools.

Tested with **VMware ESX 7** and Ubuntu ISOs ubuntu-20.04.3-live-server-arm64 & ubuntu-21.10-live-server-arm64

# Requirements: #

* Packer --> https://www.packer.io

# How to use: #
Modify the variablesarm.json to include your setup such as SSO password and ARM clusters
execute **packer build -var-file=variablesarm.json ubuntuarm.json**
