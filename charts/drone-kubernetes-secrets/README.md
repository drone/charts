# Drone Kubernetes Secrets extension

[Drone](http://drone.io/) is a Continuous Integration platform built on container technology with native Kubernetes support.

This Chart is for installing the [Kubernetes Secrets extension](https://github.com/drone/drone-kubernetes-secrets) for Drone.

## Installing Drone Kubernetes Secrets extension

See the [drone-kubernetes-secrets chart installation guide](./docs/install.md).

## Configuring Drone Kubernetes Secrets extension

See [values.yaml](values.yaml) to see the Chart's default values.

To adjust an existing Drone install's configuration:

```console
# If you have a values file:
helm upgrade drone-kubernetes-secrets drone/drone-kubernetes-secrets --namespace drone --values drone-kubernetes-secrets-values.yaml
# If you want to change one value and don't have a values file:
helm upgrade drone-kubernetes-secrets drone/drone-kubernetes-secrets --namespace drone --reuse-values --set someKey=someVal
```

## Upgrading Drone Kubernetes Secrets extension

Read the [release notes](https://discourse.drone.io/c/announcements/6) to make sure there are no backwards incompatible changes. Make adjustments to your values as needed, then run `helm upgrade`:

```console
# This pulls the latest version of the drone chart from the repo.
help repo update
helm upgrade drone-kubernetes-secrets drone/drone-kubernetes-secrets --namespace drone --values drone-kubernetes-secrets-values.yaml
```

## Uninstalling Drone Kubernetes Secrets extension

To uninstall/delete the `drone` deployment in the `drone` namespace:

```console
helm delete drone-kubernetes-secrets --namespace drone
```

Substitute your values if they differ from the examples. See `helm delete --help` for a full reference on `delete` parameters and flags.

## Support

For questions, suggestions, and discussion, visit the [Drone community site](https://discourse.drone.io/).
