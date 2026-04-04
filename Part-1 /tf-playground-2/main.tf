terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.8.0"
    }
  }
}

provider "local" {
  # Configuration options
}
resource "local_file" "deneme" {
  filename = "hello.txt"
  content = var.hello_content
}