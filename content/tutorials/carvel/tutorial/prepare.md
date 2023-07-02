---
title: "Prepare"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Prepare for the tutorial"
type: "docs"
weight: 3401
draft: false
---

### Prepare

There are a few pre-requisites for this walkthrough you need to have ready before you can get started.

- [x] Have a working [kind](https://kind.sigs.k8s.io/) development environment (Or alternative cluster with enough permissions to deploy)
- [x] Have access to a container registry (or deploy one inside your kind cluster)
- [x] Have all the [carvel](https://carvel.dev) tools locally available

### Tips

Here are a couple of tips to refer to before starting. These were received as feedback from users hitting local environment issues.

#### DNS

_It's always DNS_. Well, at least sometimes it is.

**NOTE:** This section is relevant only if you are running a local container registry in `kind` and need to do some DNS trickery to make it work.

When running a container registry such as harbor inside a kind cluster, you need to make sure that DNS is configured correctly. In this scenario you can configure coreDNS to rewrite the DNS requests for the registry to the correct IP address.

Both your local machine and the kind cluster need to be able to resolve the registry name to the correct IP address. This can be done by adding the registry name to the `/etc/hosts` file on your local machine and by configuring coreDNS to rewrite the DNS requests for the registry to the correct IP address.

- For the `kind` cluster, review the `ConfigMap` and change the settings to suit your environment.

```yaml
# coredns-config.yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: coredns
  namespace: kube-system
data:
  Corefile: |
    # Global configuration.
    (global) {
       loadbalance round_robin
       loop
       errors
       ready
       reload 30s 15s
       cache {
          success 60
          denial 30
       }
       log . {
          #class success
          class denial
       }
    }

    # Internal Cluster Network
    cluster.local in-addr.arpa ip6.arpa {

       import global
       whoami

       # Avoid hair pinning by rewriting the ingress to the internal service
       rewrite name harbor.cluster.local harbor-core.harbor.svc.cluster.local

       kubernetes {
          pods insecure
          ttl 30
          fallthrough in-addr.arpa ip6.arpa
       }
    }

    # An example local network
    saltlabs.cloud {

       import global

       # AD.saltlabs.cloud
       forward . dns://10.1.1.40 dns://10.1.2.117 dns://10.3.0.2 {

          health_check 15s
          max_concurrent 10000
          max_fails 3
          expire 60s
          policy round_robin

          except cluster.local
          except test.local
       }
    }

    # Test network
    test.local {
       # Used for testing client behavior
       erratic {
          drop 2
          truncate 2
          delay 2 100ms
       }
    }

    # Defaults
    . {
       import global
       prometheus :9153
       health {
          lameduck 5s
       }
       #forward . /etc/resolv.conf {
       #   health_check 15s
       #   max_concurrent 10000
       #
       #   except saltlabs.cloud
       #
       #}
       # AD.saltlabs.cloud
       forward . dns://10.1.1.40 dns://10.1.2.117 dns://10.3.0.2 {
          health_check 15s
          max_concurrent 10000
          max_fails 3
          expire 60s
          policy round_robin
          except cluster.local
          except test.local
       }
    }
```

- Once you have made your changes and saved to file, apply it.

```bash
kubectl apply -f coredns-config.yaml
```

- _Wait 30s for CoreDNS to apply the_ `ConfigMap` and run the verification step below.

```bash
# Run the DNS Tools Pod
kubectl run \
  -it \
  --rm \
  --restart=Never \
  --image=docker.io/infoblox/dnstools:latest \
  --namespace default \
  dnstools

# Ensure these both resolve to the same IP before exiting the pod.
nslookup harbor.cluster.local
nslookup harbor-core.harbor.svc.cluster.local

# Exit and terminate the Pod
exit
```

#### Certificates, Certificates, Certificates

When you're developing locally, you're likely be using self-signed certificates.

Be prepared to add the equivalent `--insecure-skip-tls-verify` flags to your commands or flags to blindly trust the certificates.

#### kapp-controller

For the `kapp-controller` specifically, you need to ensure that the certificate that is presented by the container registry you are using is trusted.

- You can update the `kapp-controller` `Secret` to ignore this for local testing.

```yaml
# kapp-controller-config.yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: kapp-controller-config
  namespace: kapp-controller

stringData:
  httpProxy: ""
  httpsProxy: ""

  noProxy: ""

  # YOLO for the dev environment.
  dangerousSkipTLSVerify: "harbor.cluster.local"

  # A cert chain of trusted ca certs. These will be added to the system-wide
  # cert pool of trusted ca's (optional)
  caCerts: |
    -----BEGIN CERTIFICATE-----

    -----END CERTIFICATE-----Begin
```

- Once you have made your changes and saved to file, apply it and rollout the deployment

```bash
kubectl apply -f kapp-controller-config.yaml

kubectl rollout restart -n kapp-controller deployment/kapp-controller
```

### Onwards and upwards

Ok, with that out of the way, we can get started.
