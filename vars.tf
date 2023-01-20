variable "default_tags" {
    type = map(string)
    default = {
      "env" = "terraform_testing"
    }
    description = "description my variable"
}


provider "aws" {
   
  default_tags {
    tags = var.default_tags
  }
}
