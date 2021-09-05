### Trivy Scanner Operator

This chart deploys an operator that default every 5 minutes execute a scan script. It will get image list from all namespaces with the label `trivy=true`, and then scan this images with trivy, finally we will get metrics on `http://[pod-ip]:9115/metrics`

## Configuration

The following tables lists configurable parameters of the anchore-policy-validator chart and their default values.

|               Parameter             |                Description                  |                  Default                 |
| ----------------------------------- | ------------------------------------------- | -----------------------------------------|
| image.repository                    | image | devopstales/trivy-scanner |
| image.pullPolicy                    | pullPolicy | Always |
| image.tag                           | image tag | 2.1 |
| imagePullSecrets                    | imagePullSecrets list | [] |
| podSecurityContext.fsGroup          | mount id | 10001 |
| serviceAccount.create               | create serviceAccount | true |
| serviceAccount.annotations          | add annotation to serviceAccount | {} |
| serviceAccount.name                 | name of the serviceAccount | trivy-scanner |
| monitoring.port                     | prometheus endpoint port | 9115 |
| serviceMonitor.enabled              | enable serviceMonitor object creation | false |
| serviceMonitor.namespace            | where to create serviceMonitor object | kube-system |
| storage.enabled                     | enable pv to store trivy database | true |
| storage.size                        | pv size | 1Gi |
| schedule                            | cronjob scheduler | "*/5 * * * *" |
| privateRegistry.enabled             | mount pull secret for private Registry | false |
| privateRegistry.secretName          | pull secret name for private Registry |
| githubToken.enabled                 | Enable githubToken usage for trivy database update | false |
| githubToken.token                   | githubToken value | "" |