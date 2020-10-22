# Drone server

[Drone](http://drone.io/) is a Continuous Integration platform built on container technology with native Kubernetes support.

This Chart is for installing [Drone server](https://docs.drone.io/installation/overview/).

## Installing Drone server

See the [drone chart installation guide](./docs/install.md).

## Configuring Drone server

See [values.yaml](values.yaml) to see the Chart's default values. Refer to the [Drone server reference](https://docs.drone.io/installation/reference/) for a more complete list of options.

To adjust an existing Drone install's configuration:

```console
# If you have a values file:
helm upgrade drone drone/drone --namespace drone --values drone-values.yaml
# If you want to change one value and don't have a values file:
helm upgrade drone drone/drone --namespace drone --reuse-values --set someKey=someVal
```

## Upgrading Drone server

Read the [release notes](https://discourse.drone.io/c/announcements/6) to make sure there are no backwards incompatible changes. Make adjustments to your values as needed, then run `helm upgrade`:

```console
# This pulls the latest version of the drone chart from the repo.
helm repo update
helm upgrade drone drone/drone --namespace drone --values drone-values.yaml
```

## Uninstalling Drone server

To uninstall/delete the `drone` deployment in the `drone` namespace:

```console
helm delete drone --namespace drone
```

Substitute your values if they differ from the examples. See `helm delete --help` for a full reference on `delete` parameters and flags.

## Support

For questions, suggestions, and discussion, visit the [Drone community site](https://discourse.drone.io/).
