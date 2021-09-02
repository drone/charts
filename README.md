# Drone Helm Charts

This repository hosts official [Helm](https://helm.sh/) charts for [Drone](https://drone.io/). These charts are used to deploy Drone to Kubernetes.

## Install Helm

Read and follow the [Helm installation guide](https://helm.sh/docs/intro/install/).

**Note: The charts in this repository require Helm version 3.x or later.** 

## Add the Drone Helm Chart repo

In order to be able to use the charts in this repository, add the name and URL to your Helm client:

```console
helm repo add drone https://charts.drone.io
helm repo update
```

## Install charts

See the the READMEs for the various charts in the [charts](charts) directory. 

* If you have not yet installed Drone server, start with the [drone](charts/drone) chart.
* After installing `drone`, install [drone-runner-kube](charts/drone-runner-kube) to begin executing builds.

## Documentation

See [Drone](https://drone.io/) or the [Drone documentation](https://docs.drone.io/) site for more information.

## Kubernetes version support

Due to rapid churn in the Kubernetes ecosystem, charts in this repository assume a version of Kubernetes released in the last 12 months. This typically means one of the last four releases.

**Note: While these charts may work with versions of older versions of Kubernetes, only releases made in the last year are eligible for support.**

## Helm Chart and Drone Support

Visit the [support forum](https://discourse.drone.io/) for support.

## Contributing

For details on how to contribute changes or additions to this repository, see the [Contributor's guide](CONTRIBUTING.md).

Please note that the charts within are supplied as a starting point. They are not intended to support every possible Kubernetes configurable. The maintainability of a chart decreases for every additional templated line. We suggest forking the charts if you find yourself needing non-trivial modifications.


## License

This repository's contents are licensed under the 2-clause BSD license. See the included [LICENSE](LICENSE) file for a copy.
