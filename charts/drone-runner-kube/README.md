# Drone Kubernetes runner

[Drone](http://drone.io/) is a Continuous Integration platform built on container technology with native Kubernetes support.

This Chart is for installing the [Kubernetes runner](https://kube-runner.docs.drone.io/) for Drone.

## Installing Drone Kubernetes runner

See the [drone-runner-kube chart installation guide](./docs/install.md).

## Configuring Drone Kubernetes runner

See [values.yaml](values.yaml) to see the Chart's default values. Refer to the [Kubernetes runner reference](https://kube-runner.docs.drone.io/) for a more complete list of options.

To adjust an existing Drone install's configuration:

```console
# If you have a values file:
helm upgrade drone-runner-kube drone/drone-runner-kube --namespace drone --values drone-runner-kube-values.yaml
# If you want to change one value and don't have a values file:
helm upgrade drone-runner-kube drone/drone-runner-kube --namespace drone --reuse-values --set someKey=someVal
```

## Upgrading Drone Kubernetes runner

Read the [release notes](https://discourse.drone.io/c/announcements/6) to make sure there are no backwards incompatible changes. Make adjustments to your values as needed, then run `helm upgrade`:

```console
# This pulls the latest version of the drone chart from the repo.
help repo update
helm upgrade drone-runner-kube drone/drone-runner-kube --namespace drone --values drone-runner-kube-values.yaml
```

## Uninstalling Drone Kubernetes runner

To uninstall/delete the `drone` deployment in the `drone` namespace:

```console
helm delete drone-runner-kube --namespace drone
```

Substitute your values if they differ from the examples. See `helm delete --help` for a full reference on `delete` parameters and flags.

## Support

For questions, suggestions, and discussion, visit the [Drone community site](https://discourse.drone.io/).
