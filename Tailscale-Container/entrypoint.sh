#!/bin/bash

service ssh restart
tailscaled&

tailscale login

tailscale up

tail -f /dev/null
