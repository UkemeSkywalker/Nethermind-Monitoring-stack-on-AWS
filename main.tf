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


  provisioner "remote-exec" {
    inline = [
    "sudo -E -n apt-get update && sudo -E -n apt-get install -y docker docker-compose",
    "git clone https://github.com/NethermindEth/metrics-infrastructure.git",
    "cp -r metrics-infrastructure/grafana metrics-infrastructure/prometheus .",
    "export HOST=$(curl ifconfig.me)",
    "export NAME=\"Nethermind node on ${var.config}\"",
    "sed -i '10s/.*/            - NETHERMIND_CONFIG=${var.config}/' docker-compose.yaml",
    "sed -i '11s/.*/            - NETHERMIND_JSONRPCCONFIG_ENABLED=${var.rpc_enabled}/' docker-compose.yaml",
    "sed -i '36s/.*/            <target xsi:type=\"Seq\" serverUrl=\"'\"http:\\/\\/$HOST:5341\"'\" apiKey=\"Test\">/' NLog.config",
    "sudo -E -n mv ./docker-compose.yaml /root/docker-compose.yaml",
    "sudo -E -n chown root:root /root/docker-compose.yaml",
    "sudo -E -n mv ./NLog.config /root/NLog.config",
    "sudo -E -n chown root:root /root/NLog.config",
    "sudo -E -n docker-compose up -d",
    "if [ $? -eq 0 ]; then echo 'Provisioning successful'; else echo 'Provisioning failed'; fi"
  ]


  }
}