provider "google" {
    project = "ibrolord"
}

module "lazylifetech" {
    source = "./zone"
    name = "lazylife.tech"
    dns_zone = "lazylifetech"
    ip_address = "34.75.191.121"
    rrecord {
        name = "www"
        type = "A"
        rrdata = "34.75.191.121"
    }
    
}
