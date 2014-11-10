# Puppet Master Test-Dev-Bed

This project is currently obsolete and has been replaced by The Forman Test-Dev-Bed.

## Overview

This repo sets up a local testing and developemnt environment using Vagrant and Virtualbox. Adjust values in the Vagrantfile/bootstrap according your environment.

## Features

The environment by default sets up
* a puppet master by installing a PE on a VM
* 4 nodes registered to the puppet master
* the following infra nodes: gridadmin01, service01, grid02

## Requirements

* [Vagrant Hosts Plugin](https://github.com/adrienthebo/vagrant-hosts)
* a `pe_answerfile` in toplevel directory that is used to install PE

To setup the above requirements run the following commands:

    vagrant plugin install vagrant-hosts

## Copyright and License

This software is licensed under the MIT license. The license is provided in the [license file](https://github.com/mrolli/petestbed/blob/master/LICENSE).

Copyright (c) 2014 IT Services Department, University of Bern
