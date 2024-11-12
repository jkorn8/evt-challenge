resource "aws_dynamodb_table" "evt-spells" {
  name           = "evt-spells"
  billing_mode   = "PROVISIONED"
  hash_key       = "spellId"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "spellId"
    type = "S"
  }
}