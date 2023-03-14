# DevOpsTales [Helm](https://helm.sh) Charts

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This repository contains [Helm](https://helm.sh) charts for various projects

* [Trivy Operator](charts/trivy-operator/)
* [KubeDash](charts/kubedash/) - Kubernetes Dashboard
* [PushProx](charts/PushProx)
* [Permission Manager](charts/permission-manager/)
* [kuberos](charts/kuberos/)
* [k8s-logrotate](charts/k8s-logrotate)
* [kube-openid-connect](charts/kube-openid-connect/) - :warning: Deprecated
* [Trivy Image Validator Admission Controller](charts/trivy-image-validator/) - :warning: Deprecated
* [Trivy Scanner Operator](charts/trivy-scanner/) - :warning: Deprecated

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add devopstales https://devopstales.github.io/helm-charts
```

You can then run `helm search repo devopstales` to see the charts.

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
Chart documentation is available in charts directoris.

## Contributing

## License

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
[Apache 2.0 License](https://github.com/devopstales/helm-charts/blob/main/LICENSE).

