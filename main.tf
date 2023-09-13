resource "aws_instance" "nethermind-client" {
  ami           = var.ami 
  instance_type = var.instance_type
  key_name      = var.key_name 
  security_groups = ["default"]


  connection {
  type        = "ssh"
  user        = "ubuntu" # or the appropriate username for your AMI
  private_key = file("./Nethermind-Node.pem")
  host        = self.public_ip
  }

provisioner "file" {
    source      = "./docker-compose.yml"
    destination = "/home/ubuntu/docker-compose.yaml"
  }

  provisioner "file" {
    source      = "./NLog.config"
    destination = "/home/ubuntu/NLog.config"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io docker-compose git",
      "git clone https://github.com/NethermindEth/metrics-infrastructure.git",
      "cp -r metrics-infrastructure/grafana metrics-infrastructure/prometheus .",
      "export HOST=$(curl ifconfig.me)",
      "export NAME=\"Nethermind node on ${var.config}\"",
      "sed -i '10s/.*/            - NETHERMIND_CONFIG=${var.config}/' docker-compose.yaml",
      "sed -i '11s/.*/            - NETHERMIND_JSONRPCCONFIG_ENABLED=${var.rpc_enabled}/' docker-compose.yaml",
      "sed -i '36s/.*/            <target xsi:type=\"Seq\" serverUrl=\"'\"http:\\/\\/$HOST:5341\"'\" apiKey=\"Test\">/' NLog.config",
      "sudo docker-compose up -d"
    ]
  }
}