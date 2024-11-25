resource "aws_dynamodb_table" "sample_table" {
  name           = "SampleTable"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "sample_table_item" {
  table_name = aws_dynamodb_table.sample_table.name
  hash_key   = aws_dynamodb_table.sample_table.hash_key

  item = <<ITEM
{
  "ID": {"S": "1"},
  "NAME": {"S": "${var.s3_bucket_name}"}
}
ITEM
}