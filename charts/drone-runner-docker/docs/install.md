# Drone Docker runner installation with Helm

This page will guide you through using the `drone-runner-docker` Helm chart to install the Drone Docker runner.

**Note: Before beginning installation, you should have a functioning deploy of Drone server. If you still need to install Drone server, complete an install of [drone](../../drone/README.md) before continuing.**

## Disclaimer

This page is not intended to be a comprehensive guide to installing the Drone Docker runner. It will only cover the Helm/Kubernetes-specific parts of the process. For further detail, see the Drone [Docker runner installation guide](https://docs.drone.io/runner/docker/overview/).

## Configuration (values)

**Note: This guide assumes that Drone and the Docker runner are installed in the `drone` namespace. Feel free to change this as desired, but we suggest putting Drone server and the Docker runner in the same namespace as a start.**

In order to install the chart, you'll need to pass in additional configuration. This configuration comes in the form of Helm values, which are key/value pairs. A minimal install of Drone server requires the following values:

```yaml
env:
  ## REQUIRED: Set the secret secret token that the Docker runner and its runners will use
  ## to authenticate. This is commented out in order to leave you the ability to set the
  ## key via a separately provisioned secret (see existingSecretName above).
  ## Ref: https://kube-runner.docs.drone.io/installation/reference/drone-rpc-secret/
  ##
  # NOTE TO READER: Change this to match the DRONE_RPC_SECRET secret set in your drone server configs. 
  DRONE_RPC_SECRET: xxxxxxxxxxxxx
``` 

Copy these into a new file, which we'll call `drone-runner-docker-values.yaml`. Adjust the included defaults to reflect your environment. For the ful list of configurables, see the [configuration reference](https://docs.drone.io/runner/docker/configuration/). 

## Run the installation

Run `helm install` with your values provided:

```console
$ helm install --namespace drone drone-runner-docker drone/drone-runner-docker -f drone-runner-docker-values.yaml
```

To break down the above, this command means: "install the `drone/drone-runner-docker` chart as a Helm release named `drone-runner-docker` in the `drone` namespace. The `drone-runner-docker-values.yaml` file will be used for configuring Drone." See `helm install --help` for a full list of parameters and flags.

Once the `install` command is ran, your Kubernetes cluster will begin creating resources. To see how your deploy is shaping up, run:

```console
$ kubectl --namespace drone get pods
NAME                                 READY   STATUS    RESTARTS   AGE
drone-76d6bb8968-2s5n9               1/1     Running   0          1h
drone-runner-docker-696cf7b8d6-pds2h   1/1     Running   0          1m
``` 

If the `drone-runner-*` pod's state is `Running`, the runner process successfully launched. Check the logs to make sure there are no warnings or errors:

```console
$ kubectl --namespace drone logs \
    -l 'app.kubernetes.io/name=drone-runner-docker' \
    -l 'app.kubernetes.io/component=drone-runner-docker'

time="2022-05-04T16:59:44Z" level=info msg="starting the server" addr=":3000"
time="2022-05-04T16:59:44Z" level=info msg="successfully pinged the remote server"
time="2022-05-04T16:59:44Z" level=info msg="polling the remote server" arch=amd64 capacity=2 endpoint="http://drone" kind=pipeline os=linux type=docker
```

If you see the "starting the server" text above without error, the Drone Docker runner is ready.

## Next steps

Now that Drone server and the Drone Docker runner are installed, you are ready to begin submitting CI builds. Refer to the [Docker runner documentation](https://docs.drone.io/pipeline/docker/overview/) for more information on how to proceed.

## Help! 

If you have questions or have encountered issues, visit the [Drone community site](https://community.harness.io/c/drone/14) to share.
