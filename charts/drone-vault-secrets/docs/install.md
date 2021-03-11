# Drone Kubernetes secrets extension installation with Helm

This page will guide you through using the `drone-vault-secrets` Helm chart to install the Drone vault Secrets extension.

**Note: Before beginning installation, you should have functioning deploys of Drone server and the Kubernetes runner. Refer to the their respective charts if needed:**

* [drone](../../drone/README.md)
* [drone-runner-kube](../../drone-runner-kube/README.md)

## Configuration (values)

**Note: This guide assumes that the Kubernetes runner and the vault secrets extension are installed in the `drone` namespace. Feel free to change this as desired, but we suggest co-locating the two in the same namespace as a start.**

In order to install the chart, you'll need to pass in additional configuration. This configuration comes in the form of Helm values, which are key/value pairs. A minimal install of Drone server requires the following values:

```yaml
rbac:
  ## The namespace that the extension is allowed to fetch secrets from. Unless
  ## rbac.restrictToSecrets is set below, the extension will be able to pull all secrets in
  ## the namespace specified here.
  ##
  secretNamespace: default

## The keys within the "env" map are mounted as environment variables on the secrets extension pod.
##
env:
  ## REQUIRED: Shared secret value for comms between the Kubernetes runner and this secrets plugin.
  ## Must match the value set in the runner's env.DRONE_SECRET_PLUGIN_TOKEN.
  ## Ref: https://kube-runner.docs.drone.io/installation/reference/drone-secret-plugin-token/
  ##
  DRONE_SECRET: your-shared-secret-value-here

  ## The Kubernetes namespace to retrieve secrets from.
  ##
  KUBERNETES_NAMESPACE: default
``` 

Copy these into a new file, which we'll call `drone-vault-secrets-values.yaml`. Adjust the included defaults to reflect your environment. Make note of the value that you use for `SECRET_KEY`, as you'll need to set that in the Kubernetes runner's config.

## Run the installation

Run `helm install` with your values provided:

```console
$ helm install --namespace drone drone-vault-secrets drone/drone-vault-secrets -f drone-vault-secrets-values.yaml
```

To break down the above, this command means: "install the `drone/drone-vault-secrets` chart as a Helm release named `drone-vault-secrets` in the `drone` namespace. The `drone-vault-secrets.yaml` file will be used for configuring Drone." See `helm install --help` for a full list of parameters and flags.

Once the `install` command is ran, your Kubernetes cluster will begin creating resources. To see how your deploy is shaping up, run:

```console
$ kubectl --namespace drone get pods
NAME                                        READY   STATUS    RESTARTS   AGE
drone-76d6bb8968-2s5n9                      1/1     Running   0          1h
drone-runner-kube-696cf7b8d6-pds2h          1/1     Running   0          10m
drone-vault-secrets-547799b4db-c58wv   1/1     Running   0          1m
```

If the `drone-vault-secrets-*` pod's state is `Running`, the secret extension process successfully launched. Check the logs to make sure there are no warnings or errors:

```console
$ kubectl --namespace drone logs \
    -l 'app.kubernetes.io/name=drone-vault-secrets' \
    -l 'app.kubernetes.io/component=drone-vault-secrets'

time="2020-01-29T00:02:18Z" level=info msg="server listening on address :3000"
```

If you see the "starting the server" text above without error, the Drone vault secrets extension is ready.

## Point Drone Kubernetes runner at Drone vault secrets

Now that you have the vault secrets extension installed alongside Drone Kubernetes runner and Drone server, you'll need to update your Drone Kubernetes runner configs to point at the secrets extension. Within your values for the Kubernetes runner, add the following environment variables to the existing `env` section:

```yaml
env:
  # <... your existing values here>

  ## Ref: https://kube-runner.docs.drone.io/installation/reference/drone-secret-plugin-endpoint/
  #
  DRONE_SECRET_PLUGIN_ENDPOINT: http://drone-vault-secrets:3000
  ## Ref: https://kube-runner.docs.drone.io/installation/reference/drone-secret-plugin-token/
  #
  DRONE_SECRET_PLUGIN_TOKEN: your-shared-secret-value-here
```

The `DRONE_SECRET_PLUGIN_ENDPOINT` variable points to a Kubernetes Services that the chart created to front the secrets extension. `DRONE_SECRET_PLUGIN_TOKEN` must be the same value that you set in the secret extension's configs as `SECRET_KEY`.


## Next steps

Now that the secrets extension and Kubernetes runner are configured, see the [Kubernetes runner secrets guide](https://docs.drone.io/configure/secrets/external/vault/) for details on how to get started creating secrets and sending builds with secrets in them.

## Help!

If you have questions or have encountered issues, visit the [Drone community site](https://discourse.drone.io/) to share.
