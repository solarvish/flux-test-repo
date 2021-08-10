local argo = import 'argoapp.libsonnet';

argo.Application(name="nginx", path="k8s-manifests/nginx")

