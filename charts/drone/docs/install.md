# Drone server installation with Helm

This page will guide you through using the `drone` Helm chart to install Drone server.

## Disclaimer

This page is not intended to be a comprehensive guide to installing Drone. It will only cover the Helm/Kubernetes-specific parts of the process. For further detail, see the [Drone installation guide](https://docs.drone.io/installation/overview/).

## Configuration (values)

In order to install the chart, you'll need to pass in additional configuration. This configuration comes in the form of Helm values, which are key/value pairs. A minimal install of Drone server requires the following values:

```yaml
env:
  ## REQUIRED: Set the user-visible Drone hostname, sans protocol.
  ## Ref: https://docs.drone.io/installation/reference/drone-server-host/
  ##
  DRONE_SERVER_HOST: drone.example.com
  ## The protocol to pair with the value in DRONE_SERVER_HOST (http or https).
  ## Ref: https://docs.drone.io/installation/reference/drone-server-proto/
  ##
  DRONE_SERVER_PROTO: https
  ## REQUIRED: Set the secret secret token that the Drone server and its Runners will use
  ## to authenticate. This is commented out in order to leave you the ability to set the
  ## key via a separately provisioned secret (see existingSecretName above).
  ## Ref: https://docs.drone.io/installation/reference/drone-rpc-secret/
  ##
  DRONE_RPC_SECRET: randomly-generated-secret-here
``` 

Copy these into a new file, which we'll call `drone-values.yaml`. Adjust the included defaults to reflect your environment. For the ful list of configurables, see the [configuration reference](https://docs.drone.io/installation/reference/).

Once we have a values file started with the essentials, the next step is to configure your git provider. The full list of supported providers may be found in the [Drone install guide](https://docs.drone.io/installation/overview/). Each provider uses different config parameters. They typically include an ID and a secret.

Visit the page that corresponds to your chosen provider in the [Drone install guide](https://docs.drone.io/installation/overview/) and follow the setup instructions. The environment variables listed on the page will be added to our `drone-values.yaml` under the `env` map. Here's an example of a typical GitHub.com configuration:

```yaml
  ## GitHub provider configuration.
  ## Ref: https://docs.drone.io/installation/providers/github/
  DRONE_GITHUB_CLIENT_ID: xxxxxxxxxxxxxxxxxxxxxxx
  DRONE_GITHUB_CLIENT_SECRET: yyyyyyyyyyyyyyyyyyyyy
```

**Tip: If you use a provider other than GitHub.com, you'll have different environment variables.**

Once you have your provider configured, your `drone-values.yaml` should look something like this:

```yaml
env:
  ## REQUIRED: Set the user-visible Drone hostname, sans protocol.
  ## Ref: https://docs.drone.io/installation/reference/drone-server-host/
  ##
  DRONE_SERVER_HOST: drone.example.com
  ## The protocol to pair with the value in DRONE_SERVER_HOST (http or https).
  ## Ref: https://docs.drone.io/installation/reference/drone-server-proto/
  ##
  DRONE_SERVER_PROTO: https
  ## REQUIRED: Set the secret secret token that the Drone server and its Runners will use
  ## to authenticate. This is commented out in order to leave you the ability to set the
  ## key via a separately provisioned secret (see existingSecretName above).
  ## Ref: https://docs.drone.io/installation/reference/drone-rpc-secret/
  ##
  DRONE_RPC_SECRET: randomly-generated-secret-here
  ## GitHub provider configuration.
  ## Ref: https://docs.drone.io/installation/providers/github/
  DRONE_GITHUB_CLIENT_ID: xxxxxxxxxxxxxxxxxxxxxxx
  DRONE_GITHUB_CLIENT_SECRET: yyyyyyyyyyyyyyyyyyyyy
```

## Run the installation

**Note: For the purpose of this guide, we'll assume that Drone server is being installed into the `drone` namespace. Feel free to change this to something else if you'd prefer.**

Create the namespace to install Drone in if it does not already exist:

```console
$ kubectl create ns drone
namespace/drone created
```

Run `helm install` with your values provided:

```console
$ helm install --namespace drone drone drone/drone -f drone-values.yaml
```

To break down the above, this command means: "install the `drone/drone` chart as a Helm release named `drone` in the `drone` namespace. The `drone-values.yaml` file will be used for configuring Drone." See `helm install --help` for a full list of parameters and flags.

Once the `install` command is ran, your Kubernetes cluster will begin creating resources. To see how your deploy is shaping up, run:

```console
$ kubectl --namespace drone get pods
NAME                                 READY   STATUS    RESTARTS   AGE
drone-76d6bb8968-2s5n9               1/1     Running   0          2m
``` 

If the `drone-*` pod's state is `Running`, the Drone server process is running. Check the logs to make sure there are no warnings or errors:

```console
$ kubectl --namespace drone logs \
    -l 'app.kubernetes.io/name=drone' \
    -l 'app.kubernetes.io/component=server'

time="2020-01-26T23:49:03Z" level=info msg="starting the server" addr=":3000"
```

If you see the "starting the server" text above without error, Drone server is ready.

## Accessing Drone server

To expose Drone server to your network (or the world), there are several options:

* [Kubernetes Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
* [Kubernetes Services](https://kubernetes.io/docs/concepts/services-networking/service/) - Typically of Type=Loadbalancer or sometimes NodePort.

These topics are outside the scope of this guide, but see the chart's [values.yaml](../values.yaml) to get a feel for possibilities. Don't hesitate to ask questions in the [Drone community site](https://discourse.drone.io/) as needed.

## Next steps

Now that you have Drone server running, you'll need to install the Kubernetes runner before CI jobs will begin executing. Continue by reading the [drone-kube-runner README.md](../../drone-runner-kube/README.md) and installation instructions.

## Help! 

If you have questions or have encountered issues, visit the [Drone community site](https://discourse.drone.io/) to share.
