locals {
  slurm_cluster_jail_size             = "${ceil(var.slurm_cluster_filestores.jail.size / local.unit_gib)}Gi"
  slurm_cluster_controller_spool_size = "${ceil(var.slurm_cluster_filestores.controller_spool.size / local.unit_gib)}Gi"
}

locals {
  slurm_cluster_filestore_values_yaml = templatefile("${path.module}/slurm_cluster_filestore_values.yaml.tpl", {
    slurm_cluster_jail_size = local.slurm_cluster_jail_size,
    slurm_cluster_controller_spool_size = local.slurm_cluster_controller_spool_size,
    unit_gib = local.unit_gib,

    kube_node_group_gpu = data.nebius_kubernetes_node_group.gpu,
    kube_node_group_non_gpu = data.nebius_kubernetes_node_group.non_gpu,

    slurm_cluster_filestores = var.slurm_cluster_filestores,
  })
}

resource "helm_release" "slurm_cluster_filestore" {
  chart   = "${local.slurm_chart_path}/${local.slurm_chart_filestore}"
  name    = local.slurm_chart_filestore
  version = var.slurm_operator_version

  depends_on = [
    module.k8s_cluster,
    data.nebius_kubernetes_node_group.non_gpu,
    data.nebius_kubernetes_node_group.gpu,
    null_resource.filestore_attachment
  ]

  namespace        = local.slurm_cluster_normalized_name
  create_namespace = true

  values = [local.slurm_cluster_filestore_values_yaml]

  wait          = true
  wait_for_jobs = true
}
