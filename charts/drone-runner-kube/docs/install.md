# Drone Kubernetes runner installation with Helm

This page will guide you through using the `drone-runner-kube` Helm chart to install the Drone Kubernetes runner.

**Note: Before beginning installation, you should have a functioning deploy of Drone server. If you still need to install Drone server, complete an install of [drone](../../drone/README.md) before continuing.**

## Disclaimer

This page is not intended to be a comprehensive guide to installing the Drone Kubernetes runner. It will only cover the Helm/Kubernetes-specific parts of the process. For further detail, see the Drone [Kubernetes runner installation guide](https://kube-runner.docs.drone.io/installation/installation/).

## Configuration (values)

**Note: This guide assumes that Drone and the Kubernetes runner are installed in the `drone` namespace. Feel free to change this as desired, but we suggest putting Drone server and the Kubernetes runner in the same namespace as a start.**

In order to install the chart, you'll need to pass in additional configuration. This configuration comes in the form of Helm values, which are key/value pairs. A minimal install of Drone server requires the following values:

```yaml
## Each namespace listed below will be configured such that the runner can run build Pods in
## it. This comes in the form of a Role and a RoleBinding. If you change env.DRONE_NAMESPACE_DEFAULT
## or the other DRONE_NAMESPACE_* variables, make sure to update this list to include all
## namespaces.
rbac:
  buildNamespaces:
    - drone

env:
  ## REQUIRED: Set the secret secret token that the Kubernetes runner and its runners will use
  ## to authenticate. This is commented out in order to leave you the ability to set the
  ## key via a separately provisioned secret (see existingSecretName above).
  ## Ref: https://kube-runner.docs.drone.io/installation/reference/drone-rpc-secret/
  ##
  # NOTE TO READER: Change this to match the DRONE_RPC_SECRET secret set in your drone server configs. 
  DRONE_RPC_SECRET: xxxxxxxxxxxxx

  ## Determines the default Kubernetes namespace for Drone builds to run in.
  ## Ref: https://kube-runner.docs.drone.io/installation/reference/drone-namespace-default/
  ##
  DRONE_NAMESPACE_DEFAULT: drone
``` 

Copy these into a new file, which we'll call `drone-runner-kube-values.yaml`. Adjust the included defaults to reflect your environment. For the ful list of configurables, see the [configuration reference](https://kube-runner.docs.drone.io/installation/reference/). 

## Run the installation

Run `helm install` with your values provided:

```console
$ helm install --namespace drone drone-runner-kube drone/drone-runner-kube -f drone-runner-kube-values.yaml
```

To break down the above, this command means: "install the `drone/drone-runner-kube` chart as a Helm release named `drone-runner-kube` in the `drone` namespace. The `drone-runner-kube-values.yaml` file will be used for configuring Drone." See `helm install --help` for a full list of parameters and flags.

Once the `install` command is ran, your Kubernetes cluster will begin creating resources. To see how your deploy is shaping up, run:

```console
$ kubectl --namespace drone get pods
NAME                                 READY   STATUS    RESTARTS   AGE
drone-76d6bb8968-2s5n9               1/1     Running   0          1h
drone-runner-kube-696cf7b8d6-pds2h   1/1     Running   0          1m
``` 

If the `drone-runner-*` pod's state is `Running`, the runner process successfully launched. Check the logs to make sure there are no warnings or errors:

```console
$ kubectl --namespace drone logs \
    -l 'app.kubernetes.io/name=drone-runner-kube' \
    -l 'app.kubernetes.io/component=drone-runner-kube'

time="2020-01-26T23:49:03Z" level=info msg="starting the server" addr=":3000"
time="2020-01-26T23:49:03Z" level=info msg="successfully pinged the remote server"
time="2020-01-26T23:49:03Z" level=info msg="polling the remote server" capacity=100 endpoint="http://drone" kind=pipeline type=kubernetes
```

If you see the "starting the server" text above without error, the Drone Kubernetes runner is ready.

## Next steps

Now that Drone server and the Drone Kubernetes runner are installed, you are ready to begin submitting CI builds. Refer to the [Drone pipeline documentation](https://docs.drone.io/configure/pipeline/) and the [Kubernetes runner documentation](https://kube-runner.docs.drone.io/configuration/) for more information on how to proceed.

## Help! 

If you have questions or have encountered issues, visit the [Drone community site](https://discourse.drone.io/) to share.
