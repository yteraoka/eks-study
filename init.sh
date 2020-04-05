aws dynamodb create-table --table-name terraform-ekstest-lock \
--attribute-definitions AttributeName=LockID,AttributeType=S \
--key-schema AttributeName=LockID,KeyType=HASH \
--provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
--region ap-northeast-1

account_id=$(aws sts get-caller-identity --query Account --output text)
bucket_name="terraform-ekstest-${account_id}"

aws s3 mb s3://${bucket_name} --region ap-northeast-1
