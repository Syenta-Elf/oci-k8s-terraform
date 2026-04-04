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

output "deneme" {
  value = {
    id = local_file.deneme.id
    icerik = local_file.deneme.content
    dosya_adi = local_file.deneme.filename
  }
}