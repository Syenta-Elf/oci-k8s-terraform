## 📋 OCI Authentication Özeti

**Kurulum komutları:**

```bash
brew install oci-cli
oci --version
oci setup config
```

**Test komutu:**

```bash
oci iam region list
```

**Nasıl çalışır:**

- OCI CLI → `~/.oci/config` dosyası oluşturur
- API key pair → private key local'de, public key OCI Domain'de
- Terraform OCI provider → aynı key'i kullanır

**Önemli nokta:** Yeni OCI hesapları Identity Domain kullanıyor — key'i **Domains → Users → API keys** sayfasına eklemek gerekiyor, "My profile" değil.

**Terraform komutları:**

```bash
terraform init      # OCI provider'ı indirir
terraform plan      # değişiklikleri gösterir
```

**Güvenlik:** `terraform.tfvars` → `.gitignore`'a ekle!

---

`terraform.tfvars` dosyasını `.gitignore`'a ekledin mi? 😄
