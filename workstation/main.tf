resource "digitalocean_droplet" "dev" {
  ssh_keys= [23874093]
  count = 1
  image = "ubuntu-18-10-x64"
  name = "dev-${count.index}"
  region = "nyc1"
  size = "512mb"
 private_networking = true
 backups = true
 ipv6 = true
 /* ssh_keys = [
    "${var.ssh_fingerprint}"
  ] */
  lifecycle {
    create_before_destroy = true
  }
provisioner "remote-exec" {
    script = "bootstrap.sh"

  connection {
    user = "root"
    type = "ssh"
	private_key = "${file("~/.ssh/dokey")}"
    timeout = "2m"
    }
  }

provisioner "file" {
    source      = "pull-secrets.sh"
    destination = "/mnt/secrets/pull-secrets.sh"

    connection {
      type        = "ssh"
	  private_key = "${file("~/.ssh/dokey")}"
      user        = "root"
      timeout     = "2m"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /mnt/secrets/pull-secrets.sh",
    ]

    connection {
      type        = "ssh"
	  private_key = "${file("~/.ssh/dokey")}"
      user        = "root"
      timeout     = "2m"
    }
  }
}

resource "digitalocean_firewall" "dev" {
  name = "dev"

  droplet_ids = ["${digitalocean_droplet.dev.id}"]

  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "3222"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "udp"
      port_range       = "60000-60010"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}

output "Name" {
  value = "${digitalocean_droplet.dev.name}"
}
output "public_ip" {
    value = "${digitalocean_droplet.dev.ipv4_address}"
}
