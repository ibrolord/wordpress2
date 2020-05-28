variable "general_purpose_machine_type" {
    type = string
    description = "Node pool machine type https://cloud.google.com/compute/docs/machine-types"
}

variable "general_purpose_min_node_count" {
    type = string
    description = "Min No of nodes per zone"
    default = 1
}

variable "general_purpose_max_node_count" {
    type = string
    description = "Max No of nodes per zone"
    default = 2
}

resource "${google_container_cluster" "cluster" {
    name = "${var.project-cluster}"
    location = "${var.region}"

    # We can't create a cluster with no node pool defined, but we want to only use
    # separately managed node pools. So we create the smallest possible default
    # node pool and immediately delete it.
    
    remove_default_node_pool = true
    initial_node_count = 1

    # Setting an empty username and password explicitly disables basic auth
    master_auth {
        username = ""
        password = ""
    }

    addons_config {
        network_policy_config {
            disabled = "false"
        }
    }

    network_policy {
        enabled = "true"
        provider = "CALICO"
    }
}

resource "google_container_node_pool" "general_purpose" {
    name       = "${var.project-general}"
    location   = "${var.region}"
    cluster    = "${google_container_cluster.cluster.name}"
    #node_count = 1

    management {
        auto_repair = "true"
        auto_upgrade = "true"
    }

    autoscaling {
        min_node_count = "${var.general_purpose_min_node_count}"
        max_node_count = "${var.general_purpose_max_node_count}"
    }    
    
    initial_node_count = "${var.general_purpose_min_node_count}"

    node_config {
        preemptible  = true
        machine_type = "${var.general_purpose_machine_type}"

        metadata = {
            disable-legacy-endpoints = "true"
        }

        oauth_scopes = [
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring",
            "https://www.googleapis.com/auth/devstorage.read_only"
            ]
        }
}


output "client_certificate" {
    value = "${google_container_cluster.cluster.master_auth.0.client_certificate}"
}

output "client_key" {
    value = "${google_container_cluster.cluster.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
    value = "${google_container_cluster.cluster.master_auth.0.cluster_ca_certificate}"
}
