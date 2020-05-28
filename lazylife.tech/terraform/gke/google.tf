variable "project" {
    type = string
    description = "Google Cloud Project Name"
}

variable "region" {
    type = string
    description = "Default Google Cloud Region"
}

terraform {
    backend "gcs" {
        bucket = "gke-from-scratch-terraform-state-ibro"
        prefix = "terraform"
        credentials = "account.json"
    }
}

provider "google" {
    credentials = "${file("account.json")}"
    project = "var.project"
    region = "var.region"
}
