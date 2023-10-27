# Packer Nginx WS

This is a woskpace for building a custom AMI with Packer using [Crola1702-buildfarm chef-nginx](https://github.com/Crola1702-buildfarm/chef-nginx-ws)

It provisions the image with a [bootstrap.sh](./bootstrap.sh) script that installs everything needed to run the application.

## Usage

1. Copy the `.envrc.example` to `.envrc` and fill in the variables
2. Run `source .envrc` to load the environment variables
3. Run `packer build .` to build the AMI
    * The packer template contains a breakpoint that allows you to check the logs and determine if the build was successful


