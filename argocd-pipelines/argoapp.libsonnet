local lib = import 'library-ext.libsonnet';

local append_overlay(path, overlay) =
   path + (if std.endsWith(path, "/") then "" else "/") + "overlays/" + overlay
;

{
   Application(name, path, namespace='default', overlay_override='')::
   {
      apiVersion: "argoproj.io/v1alpha1",
      kind: "Application",
      metadata: { name: name + "-" + std.extVar('target') },
      spec: {
         project: std.extVar('project'),
         source: {
            repoURL: "https://github.com/solarvish/flux-test-repo.git",
            targetRevision: std.extVar('branch'),
            overlay_overrides:: std.parseJson(std.extVar('overlay_overrides')),
            overlay:: if std.objectHas(self.overlay_overrides, name) then
                         self.overlay_overrides[name]
                      else if overlay_override != '' then
                         overlay_override
                     else
                         std.extVar('overlay'),
            path: append_overlay(path, self.overlay),
         },
         destination: {
            server: std.extVar('destination'),
            namespace: namespace
         },
         syncPolicy: {
            automated: { prune: true }
         }
      }
   }
}
