local argo = import 'argoapp.libsonnet';

local overlay = std.extVar('ksm_overlay');

argo.Application(name="kube-state-metrics", path="k8s-manifests/kube-state-metrics", overlay_override=overlay)

