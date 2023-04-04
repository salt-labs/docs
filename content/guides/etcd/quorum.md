# Readme

- [ ] capture pod and container info

```bash
crictl inspectp <pod-id> > pod.json
crictl inspect <container-id> > container.json
```

- [ ] modify files to include `--force-new-cluster`

```bash
vim pod.json
vim container.json
```

- [ ] Create the container, passing the ID of the previously-created pod, the container config file, and the pod config file. The ID of the container is returned.

````bash
crictl create $POD_ID container.json pod.json

- [ ] Verify the container is running

```bash
crictl ps -a
````

- Verify etcd container logs and test kube-apiserver

```bash
crictl logs $CONTAINER_ID

kubectl get nodes
```

- Do some etcd stuff to cleanup

```bash
etcdctl member list
etcdctl member remove <member-id>
etcdctl endpoint health
```

- Once healthy, take a snapshot

```bash
ETCDCTL_API=3 etcdctl --endpoints $ENDPOINT snapshot save snapshot.db
```

- Stop the container and drop the `--force-new-cluster` flag

```bash
crictl stop $CONTAINER_ID
vim container.json
```

- Once healthy, fixup the control-plane to be 1 node

- Then, once healthy, add additional etcd nodes back into cluster.

## Links

- [containerd crictl documentation](https://github.com/containerd/containerd/blob/main/docs/cri/crictl.md)
- [Kubernetes Debugging with crictl](https://kubernetes.io/docs/tasks/debug/debug-cluster/crictl/)
- [crictl man page](https://www.mankier.com/1/crictl)
- [CRI-O crictl tutorial](https://fossies.org/linux/cri-o/tutorials/crictl.md)
- [etcd Recovery Guide](https://etcd.io/docs/v3.3/op-guide/recovery/)
- [VMware KB 91164](https://kb.vmware.com/s/article/91164)
- [VMware vSphere with Tanzu Guide](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-29DA638D-23B5-4A53-9152-7BD5D5F85BFE.html)
- [etcd Configuration Guide](https://etcd.io/docs/v3.2/op-guide/configuration/)
- [Kubernetes map-crictl-dockercli](https://kubernetes.io/docs/reference/tools/map-crictl-dockercli/)
- [Kubernetes SIGs cri-tools crictl documentation](https://github.com/kubernetes-sigs/cri-tools/blob/master/docs/crictl.md)
- [VMware vSphere with Tanzu TKG Guide](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-tkg/GUID-3D8F1DB0-43B0-4D33-B668-513F1568FACB.html)
