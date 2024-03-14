#!/bin/bash

mkdir -p tailscale_state

docker run \
    --rm \
    -it \
    -p 127.0.0.1:2244:22 \
    -v $(pwd)/tailscale_state:/var/lib/tailscale \
    --privileged \
    --cap-add=NET_ADMIN \
    tailscale-tunnel
