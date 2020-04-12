# EKS 学習用 Terraform

```
                               +--------------------------+
                               |     Internet Gateway     |
                               +--------------------------+

+--------------------------+   +--------------------------+   +--------------------------+
|                          |   |                          |   |                          |
|  +--------------------+  |   |  +--------------------+  |   |  +--------------------+  |
|  |                    |  |   |  |                    |  |   |  |                    |  |
|  | Public Subnet [0]  |  |   |  | Public Subnet [1]  |  |   |  | Public Subnet [2]  |  |
|  |                    |  |   |  |                    |  |   |  |                    |  |
|  | Nat Gateway [0]    |  |   |  | (Nat Gateway [1])  |  |   |  | (Nat Gateway [2])  |  |
|  |                    |  |   |  |                    |  |   |  |                    |  |
|  +--------------------+  |   |  +--------------------+  |   |  +--------------------+  |
|                          |   |                          |   |                          |
|  +--------------------+  |   |  +--------------------+  |   |  +--------------------+  |
|  |                    |  |   |  |                    |  |   |  |                    |  |
|  | Private Subnet [0] |  |   |  | Private Subnet [1] |  |   |  | Private Subnet [2] |  |
|  |                    |  |   |  |                    |  |   |  |                    |  |
|  +--------------------+  |   |  +--------------------+  |   |  +--------------------+  |
|                          |   |                          |   |                          |
+--------------------------+   +--------------------------+   +--------------------------+
```

- Nat Gateway はお金がかかるので1つだけにしておく
- Terraform の [templatefile()](https://www.terraform.io/docs/configuration/functions/templatefile.html) を使って eksctl 用の YAML ファイルを生成する

## terraform の適用

```
./init.sh
cd terraform
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

## EKS Cluster の作成

```
cd terraform
eksctl create cluster -f eksctl-cluster-generated.yaml
```


## EKS Cluster の削除

```
eksctl delete cluster --name ekstest [--wait]
```

## お金のかかるリソースの削除

```
cd terraform
terraform destroy -target aws_eip.nat -target aws_nat_gateway.nat
```
