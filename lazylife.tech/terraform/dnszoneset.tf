provider "google" {
    project = "ibrobaba"
}

resource "google_dns_managed_zone" "lazylifetech" {
  name     = "lazylifetech"
  dns_name = "lazylife.tech."
}

resource "google_dns_record_set" "lazylifetech" {
  managed_zone = google_dns_managed_zone.lazylifetech.name

  name    = "www.${google_dns_managed_zone.lazylifetech.dns_name}"
  type    = "A"
  rrdatas = ["34.75.82.134"]
  ttl     = 5
}


resource "google_dns_record_set" "lazylifetech2" {
  managed_zone = google_dns_managed_zone.lazylifetech.name

  name    = "${google_dns_managed_zone.lazylifetech.dns_name}"
  type    = "A"
  rrdatas = ["34.75.82.134"]
  ttl     = 5
}
