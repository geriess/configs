resource "digitalocean_droplet" "dev" {
  image = "ubuntu-18-10-x64"
  name = "dev"
  region = "nyc1"
  size = "512mb"
  private_networking = true
  user_data = "${file("config/webuserdata.sh")}"
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  lifecycle {
    create_before_destroy = true
  }
  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }
}

