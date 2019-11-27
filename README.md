# iPXE boot on VirtualBox

This repo contains some helper scripts to quickly create a cluster
of vms configured for iPXE booting on VirtualBox.

These scripts have been tested on a MacBook Pro (currenty the script assumes the
bridgeadapter name to be `'en0: Wi-Fi (AirPort)'`) in combination with Digital Rebar
in DHCP proxy mode running on a Synology NAS (using docker).

## Usage

Create a cluster

```
./up.sh 3 # will create 3 nodes
```

Delete your cluster

```
./down.sh 3 # will destory the 3 nodes
```
