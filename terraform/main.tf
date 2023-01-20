provider "aws" {
  region = "us-east-1"
  profile = "Abraham"
}

resource "aws_db_instance" "planetarium" {
  allocated_storage    = 20
  db_name              = "planetarium"
  engine               = "Postgres"
  engine_version       = "13.7"
  instance_class       = "db.t3.micro"
  username             = var.username
  password             = var.password
  parameter_group_name = "default.postgres13"
  skip_final_snapshot  = true
}

resource "aws_s3_bucket" "terraform_state" {
  
  bucket = "teamkuberknights-bucket-01" 
  lifecycle {
    prevent_destroy = true 
  }
    
  versioning {
    enabled = true 
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
  