The following tables lists configurable parameters of the trivy-operator chart and their default values.

|               Parameter             |                Description                  |                  Default                 |
| ----------------------------------- | ------------------------------------------- | -----------------------------------------|
| TimeZone                            | Tomezone for container time | Europe/Budapest |
| server.debug                        | enable debug logging | false |
| server.oidcOutURL                   | Where to redirect after logout? | https://devopstales.github.io/tags/kube-openid-connect/ |
| server.oidcRedirectUrlHttpScema     | Ingress schema (http or https) | http |
| server.oidcRedirectUrlHost          | Ingress hostname | chart-example.local |
| server.oidcServerURL                | URL of OIDC provider endpoint | Not set |
| server.oidcClientID                 | Your unique client ID | Not set |
| server.oidcSecret                   | The password for the Client ID | Not set |
| server.k8sContext                   | Context of the cluster in generated config | Not set |
| server.k8sApiServer                 | The endpoint for kubectl to use | Not set |
| server.k8sCaCrt                     | The Public CA cert for the cluster | Not set |
| image.repository                    | image | devopstales/trivy-operator | See values.yaml |
| image.pullPolicy                    | pullPolicy | Always |
| image.tag                           | image tag | 1.0 |
| imagePullSecrets                    | imagePullSecrets list | `[]` |
| nameOverride                        | Override the name part | Not set |
| fullnameOverride                    | Override the full name | Not set |
| serviceAccount.create               | create serviceAccount | true |
| serviceAccount.annotations          | add annotation to serviceAccount | `{}` |
| serviceAccount.name                 | name of the serviceAccount | Not set |
| podAnnotations                      | add extra annotations for the pod | `{}` |
| podSecurityContext.fsGroup          | mount id | 10001 |
| securityContext                     | add extra securityContext for the pod | `{}` |
| service.port                        | port number | 5000 |
| service.type                        | type of the service | ClusterIP |
| ingress.enabled                     | enable ingress | true |
| ingress.className                   | ingress calss | Not Set |
| ingress.annotations                 | extra annotation to ingress | Not set |
| ingress.hosts.host                  | hostname for ingress | chart-example.local |
| ingress.hosts.paths[0].path         | subpath on ingress | `\` |
| ingress.hosts.paths[0].pathType     | ingress path type | ImplementationSpecific |
| ingress.tls                         | tls config for ingress | `[]` |

## OIDC (Provider) Setup

You will need to obtain the OIDC details of the provider you need to use. This will contain the Issuer URL, Client ID and the Client Secret.
In the case of Google (The provider which was used when initially creating this) go to the [Developer / Credentials](https://console.developers.google.com/apis/credentials) console. You will need to add the ingress url to both
* *Authorised JavaScript origins* - https://kubeauth.k8s.intra
* *Authorised redirect URIs* - https://kubeauth.k8s.intra/callback

If you used kops the credentials you're after are
```yaml
apiVersion: kops/v1alpha2
kind: Cluster
  authorization:
    rbac: {}
  kubeAPIServer:
    authorizationRbacSuperUser: admin
    oidcClientID: UNIQUE_ID_REDACTED.apps.googleusercontent.com
    oidcIssuerURL: https://accounts.google.com
    oidcUsernameClaim: email
```

For G Suite :
The redacted part of a ClientID is about 45 alphanumeric characters long (may also contain a hyphen or two)
The client secret will be about 25 alphanumeric chacters (may also contain a hyphen or two)

For manually configure the Kubernetes ApiServer integration with OpeniD provider:

```yaml
nano /etc/kubernetes/manifests/kube-apiserver.yaml
---
...
command:
- /hyperkube
- apiserver
...
- --oidc-issuer-url={{ .Values.server.oidcServerURL }}
- --oidc-client-id={{ .Values.server.oidcClientID }}
- --oidc-username-claim=email
- --oidc-groups-claim=groups
# for self sign cert or custom ca
#- --oidc-ca-file=/etc/kubernetes/pki/rootca.pem
```

```bash
systemctl restart kubelet
```