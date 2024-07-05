########################################################################################################################
# K8S cluster settings. It configures K8S cluster, network, node groups, GPU & network operators.
########################################################################################################################

# Folder ID to create K8S cluster in.
k8s_folder_id = "bje82q7sm8njm3c4rrlq"

k8s_network_id = "btce08cojgqubmtiqp9j"

# K8S cluster name. A short random suffix will be added.
k8s_cluster_name = "slurm-test-import-network"

# K8S cluster description.
k8s_cluster_description = "K8S cluster for Slurm"

# Version of the cluster.
k8s_cluster_version = "1.28"

# IPv4 CIDR blocks for the subnet.
k8s_cluster_subnet_cidr_blocks = ["192.168.10.0/24"]

# Availability zone of the K8S cluster.
k8s_cluster_zone_id = "eu-north1-c"

# K8S cluster maintenance settings.
k8s_cluster_master_maintenance_windows = [{
  day        = "monday"
  start_time = "20:00"
  duration   = "3h"
}]

# Configuration of the node group without GPUs.
k8s_cluster_node_group_non_gpu = {
  size         = 2
  cpu_cores    = 8
  memory_gb    = 32
  disk_type    = "network-ssd"
  disk_size_gb = 128
}

# Configuration of the node group with GPUs.
k8s_cluster_node_group_gpu = {
  platform                      = "h100"
  size                          = 2
  cpu_cores                     = 160
  memory_gb                     = 1280
  gpus                          = 8
  interconnect_type             = "InfiniBand"
  interconnect_physical_cluster = "fabric-1"
  disk_type                     = "network-ssd"
  disk_size_gb                  = 128
  gke_accelerator               = "nvidia-h100-80gb"
  driver_config                 = "535"
  preemptible                   = false
}

# SSH username for connecting to K8S cluster.
k8s_cluster_ssh_username = "ubuntu"

# SSH public key for connecting to K8S cluster.
k8s_cluster_ssh_public_key      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxkjzPQ4EyZSjan4MLGFSA18idpZicoKW7HC4YmwgN rdjjke@gmail.com"
k8s_cluster_ssh_public_key_path = null

# Block size for all used filestores.
k8s_cluster_filestore_block_size = 32768

# GPU operator version.
k8s_cluster_operator_gpu_version = "v23.9.0"

# Whether to use nvidia-container-toolkit.
k8s_cluster_operator_gpu_cuda_toolkit = true

# Whether to enable GPU driver RDMA.
k8s_cluster_operator_gpu_driver_rdma = true

# NVIDIA driver version.
k8s_cluster_operator_gpu_driver_version = "535.104.12"

# Network operator version.
k8s_cluster_operator_network_version = "23.7.0"

########################################################################################################################
# Slurm operator settings. It configures 3 Helm charts: slurm-operator, slurm-cluster, and slurm-cluster-storage.
########################################################################################################################

# Version of the Slurm operator. This setting does almost nothing at the moment.
slurm_operator_version = "0.1.13"

# Whether to create a Slurm cluster custom resource in K8S. If false, only the operator is created, without a cluster.
slurm_cluster_create_cr = true

# Name of the Slurm cluster.
slurm_cluster_name = "slurm-dev"

# SSH keys that can be used for connecting to the Slurm cluster as user root.
slurm_cluster_ssh_root_public_keys = [
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxkjzPQ4EyZSjan4MLGFSA18idpZicoKW7HC4YmwgN rdjjke@gmail.com",
]

# Number of controller nodes. There's little sense in setting it more than 2.
slurm_cluster_node_controller_count = 2

# Number of worker nodes.
slurm_cluster_node_worker_count = 2

# Number of login nodes.
slurm_cluster_node_login_count = 2

# Dedicated resources for slurmctld daemon on controller nodes. If set to null, the container will have no resource
# requests & limits.
slurm_cluster_node_controller_slurmctld_resources = {
  cpu_cores               = 1
  memory_bytes            = 3 * (1024 * 1024 * 1024)  # 3Gi
  ephemeral_storage_bytes = 20 * (1024 * 1024 * 1024) # 20Gi
}

# Dedicated resources for munge daemon on controller nodes. If set to null, the container will have no resource
# requests & limits.
slurm_cluster_node_controller_munge_resources = {
  cpu_cores               = 1
  memory_bytes            = 1 * (1024 * 1024 * 1024) # 1Gi
  ephemeral_storage_bytes = 5 * (1024 * 1024 * 1024) # 5Gi
}

# Dedicated resources for slurmd daemon on worker nodes. If set to null, the container will have no resource
# requests & limits.
slurm_cluster_node_worker_slurmd_resources = {
  cpu_cores               = 156
  memory_bytes            = 1220 * (1024 * 1024 * 1024) # 1220Gi
  ephemeral_storage_bytes = 55 * (1024 * 1024 * 1024)   # 55Gi
}

# Dedicated resources for munge daemon on worker nodes. If set to null, the container will have no resource
# requests & limits.
slurm_cluster_node_worker_munge_resources = {
  cpu_cores               = 2
  memory_bytes            = 4 * (1024 * 1024 * 1024) # 4Gi
  ephemeral_storage_bytes = 5 * (1024 * 1024 * 1024) # 5Gi
}

# Dedicated resources for sshd daemon on login nodes. If set to null, the container will have no resource
# requests & limits.
slurm_cluster_node_login_sshd_resources = {
  cpu_cores               = 3
  memory_bytes            = 9 * (1024 * 1024 * 1024)  # 9Gi
  ephemeral_storage_bytes = 30 * (1024 * 1024 * 1024) # 300Gi
}

# Dedicated resources for munge daemon on login nodes. If set to null, the container will have no resource
# requests & limits.
slurm_cluster_node_login_munge_resources = {
  cpu_cores               = 0.5
  memory_bytes            = 0.5 * (1024 * 1024 * 1024) # 512Mi
  ephemeral_storage_bytes = 5 * (1024 * 1024 * 1024)   # 5Gi
}

# Configuration of the shared storages mounted to Slurm nodes.
slurm_cluster_storages = {
  jail = {
    name = "jail"
    size = 1115 * (1024 * 1024 * 1024) # 1115Gi
    type = "glusterfs"
  }
  controller_spool = {
    name = "controller-spool"
    size = 30 * (1024 * 1024 * 1024) # 30Gi
  }
  jail_submounts = [{
    name      = "mlperf-sd"
    size      = 1500 * (1024 * 1024 * 1024) # 1500Gi
    mountPath = "/mlperf-sd"
  }]
}

# If set, this disk will be used to copy the initial content from there to the operator.
slurm_cluster_jail_snapshot = null

# Size of the local disk on each worker node. Stores the "host" filesystem and node-local directories.
slurm_cluster_worker_volume_spool_size = 128 * (1024 * 1024 * 1024) # 128Gi

# Cron string representing the schedule of running NCCL benchmarks.
slurm_cluster_nccl_benchmark_schedule = "0 */3 * * *"

# Configuration of NCCL benchmarks. Most of the parameters are just passed into all_reduce_perf NCCL test.
slurm_cluster_nccl_benchmark_settings = {
  min_bytes           = "512Mb"
  max_bytes           = "8Gb"
  step_factor         = "2"
  timeout             = "20:00"
  threshold_more_than = "420"
  use_infiniband      = false
}

# Whether to drain Slurm nodes that showed unsatisfactory results.
slurm_cluster_nccl_benchmark_drain_nodes = true





########################################################################################################################
# GlusterFS cluster settings applied only when type of the jail storage is "glusterfs".
########################################################################################################################

# Folder ID where GlusterFS nodes will be created.
glusterfs_cluster_folder_id = "bje82q7sm8njm3c4rrlq"

# SSH key for connecting to GlusterFS nodes.
glusterfs_cluster_ssh_public_key      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxkjzPQ4EyZSjan4MLGFSA18idpZicoKW7HC4YmwgN rdjjke@gmail.com"
glusterfs_cluster_ssh_public_key_path = null

# Size of a single disk constituting the cluster. The total size of the storage is equal to disk size * number of nodes.
glusterfs_cluster_disk_size = 372

# Number of nodes in the cluster.
glusterfs_cluster_nodes = 3

# Number of disks on each node.
glusterfs_cluster_disks_per_node = 1
