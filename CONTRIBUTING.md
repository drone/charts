# Contributing to drone/charts

Contributions to this repository are accepted and licensed under the [2-clause BSD license](LICENSE).

## Code of conduct

Contributors must follow the [Drone community code of conduct](CODE_OF_CONDUCT.md).

## How to contribute

* Fork this repository.
* Make your changes in a branch.
* Submit a pull request.

## Philosophical notes

* This repository contains the charts necessary to deploy and operate Drone (and its supporting systems) on Kubernetes.
* The charts within are supplied as a starting point. They are not intended to support every possible Kubernetes configurable. The maintainability of a chart decreases for every additional templated line. We suggest forking the charts if you find yourself needing non-trivial modifications.
* Drone-specific chart values should mirror the naming on the Drone documentation sites. For example, `env.DRONE_RPC_HOST` instead of `server.rpc.host`. This reduces the mental friction of having to map Kubernetes-specific naming to the more general Drone documentation.

## Technical requirements

* Commit(s) should be prefixed by the name of the chart that has been added or modified.
* `helm lint` must pass for all charts.
* New charts must include a README.md. See [drone-runner-docker](charts/drone-runner-docker/README.md) for an example.  
