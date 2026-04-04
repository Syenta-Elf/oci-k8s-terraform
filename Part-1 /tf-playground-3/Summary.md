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
