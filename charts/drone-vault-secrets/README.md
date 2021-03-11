# Drone Vault Secrets extension

[Drone](http://drone.io/) is a Continuous Integration platform built on container technology with native vault support.

This Chart is for installing the [Vault Secrets extension](https://github.com/drone/drone-vault-secrets) for Drone.

## Installing Drone Vault Secrets extension

See the [drone-Vault-secrets chart installation guide](./docs/install.md).

## Configuring Drone Vault Secrets extension

See [values.yaml](values.yaml) to see the Chart's default values.

To adjust an existing Drone install's configuration:

```console
# If you have a values file:
helm upgrade drone-vault-secrets drone/drone-vault-secrets --namespace drone --values drone-vault-secrets-values.yaml
# If you want to change one value and don't have a values file:
helm upgrade drone-vault-secrets drone/drone-vault-secrets --namespace drone --reuse-values --set someKey=someVal
```

## Upgrading Drone Vault Secrets extension

Read the [release notes](https://discourse.drone.io/c/announcements/6) to make sure there are no backwards incompatible changes. Make adjustments to your values as needed, then run `helm upgrade`:

```console
# This pulls the latest version of the drone chart from the repo.
help repo update
helm upgrade drone-vault-secrets drone/drone-vault-secrets --namespace drone --values drone-vault-secrets-values.yaml
```

## Uninstalling Drone Vault Secrets extension

To uninstall/delete the `drone` deployment in the `drone` namespace:

```console
helm delete drone-vault-secrets --namespace drone
```

Substitute your values if they differ from the examples. See `helm delete --help` for a full reference on `delete` parameters and flags.

## Support

For questions, suggestions, and discussion, visit the [Drone community site](https://discourse.drone.io/).
