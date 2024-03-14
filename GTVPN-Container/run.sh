#!/bin/bash

docker run \
    --rm \
    -it \
    -p 127.0.0.1:2249:22 \
    --cap-add=NET_ADMIN \
    gtvpn-tunnel
