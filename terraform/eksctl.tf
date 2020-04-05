resource "local_file" "eksctl" {
  content = templatefile(
    "eksctl-cluster-template.yaml",
    {
      vpc             = aws_vpc.main
      public_subnets  = aws_subnet.public
      private_subnets = aws_subnet.private
      log_types       = [] # "api", "audit", "authenticator", "controllerManager", "scheduler", "*"
      node_labels = [
        { name = "node.kubernetes.io/manabed-by", value = "eksctl" }
      ]
    }
  )

  filename             = "eksctl-cluster-generated.yaml"
  file_permission      = "0644"
  directory_permission = "0755"
}
