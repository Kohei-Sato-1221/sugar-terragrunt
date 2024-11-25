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