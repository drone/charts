# Drone Docker runner

[Drone](http://drone.io/) is a Continuous Integration platform built on container technology with native Kubernetes support.

This Chart is for installing the [Docker runner](https://docs.drone.io/runner/docker/) for Drone.

## Installing Drone Docker runner

See the [drone-runner-docker chart installation guide](./docs/install.md).

## Configuring Drone Docker runner

See [values.yaml](values.yaml) to see the Chart's default values. Refer to the [Docker runner reference](https://docs.drone.io/runner/docker/configuration/reference/) for a more complete list of options.

To adjust an existing Drone install's configuration:

```console
# If you have a values file:
helm upgrade drone-runner-docker drone/drone-runner-docker --namespace drone --values drone-runner-docker-values.yaml
# If you want to change one value and don't have a values file:
helm upgrade drone-runner-docker drone/drone-runner-docker --namespace drone --reuse-values --set someKey=someVal
```

## Upgrading Drone Docker runner

Read the [release notes](https://github.com/drone-runners/drone-runner-docker/releases) to make sure there are no backwards incompatible changes. Make adjustments to your values as needed, then run `helm upgrade`:

```console
# This pulls the latest version of the drone chart from the repo.
helm repo update
helm upgrade drone-runner-docker drone/drone-runner-docker --namespace drone --values drone-runner-docker-values.yaml
```

## Uninstalling Drone Docker runner

To uninstall/delete the `drone` deployment in the `drone` namespace:

```console
helm delete drone-runner-docker --namespace drone
```

Substitute your values if they differ from the examples. See `helm delete --help` for a full reference on `delete` parameters and flags.

## Support

For questions, suggestions, and discussion, visit the [Drone community site](https://community.harness.io/c/drone).
