---
title: Rotate Certificates
date: 2023-07-10T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Harbor certificate rotation"
type: "docs"
weight: 2302
draft: false
---

## Overview

Harbor certificate rotation steps.

## Steps

- Stop the Harbor service

```bash
# Stop the systemd unit.
sudo systemctl stop harbor
```

- Backup the existing certificates

```bash
# Create a directory
sudo mkdir -p ${HOME}/backup/$(date +%Y%m%d)

# Copy the files
sudo cp /storage/data/secret/cert/server.crt ${HOME}/backup/$(date +%Y%m%d)/server.crt
sudo cp /storage/data/secret/cert/server.key ${HOME}/backup/$(date +%Y%m%d)/server.key
sudo cp /storage/data/secret/cert/ca.crt ${HOME}/backup/$(date +%Y%m%d)/ca.crt
```

- Overwrite the existing certificates with the new ones

```bash
# Place the new certificates in the ${HOME}/certs directory
sudo mkdir -p "${HOME}/certs"

# Copy the files
sudo cp "${HOME}/certs/server.crt" /storage/data/secret/cert/server.crt
sudo cp "${HOME}/certs/server.key" /storage/data/secret/cert/server.key
sudo cp "${HOME}/certs/ca.crt" /storage/data/secret/cert/ca.crt
```

- Start the Harbor service

```bash
# Start the system unit
sudo systemctl start harbor
```
