provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
  profile = "test"

}

resource "aws_s3_bucket" "terraform_state" {
  
  bucket = "teamkuberknights-bucket" 

  lifecycle{  
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
  
