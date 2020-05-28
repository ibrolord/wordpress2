variable "name" {}
variable "dns_name" {}
variable "ip_address" {}
variable "rrecord" {
    default = []
}
variable "ttl" {
    default = 3600
}

resource "google_dns_managed_zone" "managed_zone" {
    name = var.name
    dns_name = var.dns_name
    description = "DNS Zone created with Terraform with ${var.name}"
    labels = {
        project = "${var.name}"
    }
}

resource "google_dns_record_set" "default" {
    name = var.dns_name
    type = "A"
    ttl = var.ttl

    managed_zone = google_dns_managed_zone.managed_zone.name

    rrdatas = [var.ip_address]
}

resource "google_dns_record_set" "www" {
    name = "www.${var.dns_name}"
    type = "A"
    ttl = var.ttl

    managed_zone = google_dns_managed_zone.managed_zone.name

    rrdatas = [var.ip_address]
}

resource "google_dns_record_set" "record_set" {
    count = length(var.rrecord)
    name = join(".", compact(list(lookup(var.rrecord[count.index], "name", ""), var.dns_name)))
    type = lookup(var.rrecord[count.index], "type")
    ttl = var.ttl

    managed_zone = google_dns_managed_zone.managed_zone.name

    rrdatas = split(",", lookup(var.rrecord[count.index], "rrdata"))

}
