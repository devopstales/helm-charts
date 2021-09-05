### Trivy image validator
Trivy Image Validator automatically detect security issues and block before a Kubernetes pod starts.

This repository contains an admission controller that can be configured as a ValidatingWebhook in a k8s cluster. Kubernetes will send requests to the admission server when a Pod creation is initiated. The admission controller checks the image using trivy.

Inspirated by knqyf263 and his wok on trivy-enforcer.

|               Parameter             |                Description                  |                  Default                 |
| ----------------------------------- | ------------------------------------------- | -----------------------------------------|
| image.repository                    | image | devopstales/trivy-image-validator |
| image.pullPolicy                    | pullPolicy | Always |
| image.tag                           | image tag | 1.0.0 |
| imagePullSecrets                    | imagePullSecrets list | [] |
| podSecurityContext.fsGroup          | mount id | 10001 |
| storage.enabled                     | enable pv to store trivy database | true |
| storage.size                        | pv size | 1Gi |
| privateRegistry.enabled             | mount pull secret for private Registry | false |
| privateRegistry.secretName          | pull secret name for private Registry |
| serviceAccount.create               | create serviceAccount | true |
| namespace                           | namespace for cert gen | validation |
| serviceName                         | serviceName for cert gen | trivy-image-validator |
| createSelfSignedCert                | generate a cert for custom namespace or service name ro use the pre build one | false |