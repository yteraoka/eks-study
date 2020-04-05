project_name = "ekstest"

vpc_cidr = "172.31.0.0/16"

public_subnet_cidrs = [
  {
    az   = "ap-northeast-1b"
    cidr = "172.31.0.0/20"
  },
  {
    az   = "ap-northeast-1c"
    cidr = "172.31.32.0/20"
  },
  {
    az   = "ap-northeast-1d"
    cidr = "172.31.64.0/20"
  },
]

private_subnet_cidrs = [
  {
    az   = "ap-northeast-1b"
    cidr = "172.31.96.0/20"
  },
  {
    az   = "ap-northeast-1c"
    cidr = "172.31.128.0/20"
  },
  {
    az   = "ap-northeast-1d"
    cidr = "172.31.160.0/20"
  },
]
