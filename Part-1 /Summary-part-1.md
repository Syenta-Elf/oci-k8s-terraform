# 📋 Bölüm 1 Özeti

Şu ana kadar öğrendiklerin:
Terraform temel döngüsü: init → plan → apply

init → provider plugin'lerini indirir
plan → neyin değişeceğini gösterir, dokunmaz
apply → gerçekten uygular

Resource anatomy: resource "tip" "isim"
State: Terraform'un gerçekliği buradan okur
Plan sembolleri: + - ~ -/+

# 📋 Variables Özeti

variable bloğu → tanımlar, opsiyonel default ve type alır
var.isim → resource içinde kullanım
terraform.tfvars → otomatik yüklenir, default'u ezer
-var flag → tfvars'ı ezer
Hassas değerler → .gitignore'a ekle

# 📋 Outputs Özeti

Ne işe yarar: Apply sonrası önemli değerleri terminale basar. CI/CD pipeline'ında bir adımın çıktısını diğerine geçirmek için kullanılır. OCI'da cluster kurduktan sonra API endpoint'i, load balancer IP'si böyle alınır.
Temel syntax:
hcloutput "isim" {
value = resource_type.resource_name.attribute
}
Object output — birden fazla değeri gruplamak için:
hcloutput "isim" {
value = {
anahtar1 = resource.isim.attribute1
anahtar2 = resource.isim.attribute2
}
}
Sonradan görmek için:
bashterraform output
terraform output <isim>
Nerede saklanır: terraform.tfstate içinde — apply olmadan güncellenmez.

---

📋 Bölüm 1 Tam Özeti
Terraform'un temel döngüsünü ve yapı taşlarını öğrendin:
Komutlar: init → plan → apply
Dosya yapısı:

main.tf → resource'lar
variables.tf → variable tanımları
terraform.tfvars → değerler (.gitignore'a ekle!)
terraform.tfstate → gerçeklik dosyası

Bloklar: resource, variable, output
Plan sembolleri: + - ~ -/+
Variable öncelik: default → tfvars → -var flag

---
