provider "aws" {
  version = "~> 2.44"
  region  = var.region
}

provider "random" {
  version = "~> 2.2"
}

provider "local" {
  version = "~> 1.4"
}
