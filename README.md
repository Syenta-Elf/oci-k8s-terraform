# oci-k8s-terraform

Terraform ile Oracle Cloud Infrastructure (OCI) üzerinde Kubernetes cluster kurulumu ve CI/CD pipeline entegrasyonu.

![Terraform](https://img.shields.io/badge/Terraform-v1.14-623CE4?logo=terraform)
![OCI](https://img.shields.io/badge/Oracle_Cloud-Infrastructure-F80000?logo=oracle)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?logo=github-actions)

---

## 📁 Proje Yapısı

```
oci-k8s-terraform/
├── Part-1/                    # Terraform temelleri
│   ├── tf-playground-1/       # init, plan, apply
│   ├── tf-playground-2/       # variables, tfvars
│   └── tf-playground-3/       # outputs, state
└── Part-2/
    └── oci-infra/             # OCI altyapısı
        ├── modules/
│       ├── network/       # VCN, Subnet, IGW, Route Table
│       └── oke/           # OKE Cluster, Node Pool
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── providers.tf
```

---

## 🏗️ Mimari

```
GitHub Actions (CI/CD)
        │
        ▼
  Terraform (IaC)
        │
        ▼
Oracle Cloud Infrastructure
├── Object Storage (Remote State)
├── VCN (10.0.0.0/16)
│   ├── Subnet (10.0.1.0/24)
│   │   └── Route Table → Internet Gateway
│   └── Internet Gateway
└── OKE Cluster (v1.32.1)
    └── Node Pool (VM.Standard.A1.Flex — pending capacity)
```

---

## 🛠️ Kullanılan Teknolojiler

- **Terraform** v1.14 — Infrastructure as Code
- **Oracle Cloud Infrastructure (OCI)** — Cloud provider
- **OKE** — Oracle Kubernetes Engine
- **GitHub Actions** — CI/CD pipeline
- **OCI Object Storage** — Remote Terraform state

---

## 📚 Part-1: Terraform Temelleri

Terraform'un temel kavramlarını hands-on öğrenmek için yapılan çalışmalar:

- `terraform init`, `plan`, `apply`, `destroy`
- `resource`, `variable`, `output` blokları
- `terraform.tfstate` ve state yönetimi
- `terraform.tfvars` ile değer geçme
- Plan sembolleri: `+` `-` `~` `-/+`

---

## ☁️ Part-2: OCI Altyapısı

### Kurulan Kaynaklar

**Network (modules/network)**

- VCN — Virtual Cloud Network (`10.0.0.0/16`)
- Subnet (`10.0.1.0/24`)
- Internet Gateway
- Route Table (`0.0.0.0/0` → Internet Gateway)

**Compute (modules/oke)**

- OKE Cluster (Kubernetes v1.32.1)
- Node Pool konfigürasyonu (VM.Standard.A1.Flex — OCI kapasite bekleniyor)

**State Yönetimi**

- OCI Object Storage bucket ile remote state
- State locking desteği

### Öğrenilen Kavramlar

- OCI CLI kurulum ve API Key authentication (Identity Domain)
- Terraform modules — tekrar kullanılabilir yapı
- `terraform state mv` — state taşıma
- `terraform import` — mevcut kaynakları Terraform'a alma
- Terraform Workspaces — izole ortamlar
- Remote backend — `oci` backend ile OCI Object Storage

---

## 🚀 CI/CD Pipeline

`main` branch'e her push'ta otomatik olarak çalışır.

```
Push to main
    │
    ├── terraform init
    ├── terraform plan    ← Her push/PR'da
    └── terraform apply   ← Sadece main'e push'ta
```

### Pipeline Kurulumu

Gerekli GitHub Secrets:

| Secret             | Açıklama                    |
| ------------------ | --------------------------- |
| `OCI_TENANCY_OCID` | OCI Tenancy OCID            |
| `OCI_USER_OCID`    | OCI User OCID               |
| `OCI_FINGERPRINT`  | API Key fingerprint         |
| `OCI_REGION`       | OCI Region (eu-frankfurt-1) |
| `OCI_PRIVATE_KEY`  | Private key içeriği (.pem)  |

---

## ⚙️ Kullanım

### Gereksinimler

- Terraform >= 1.14
- OCI CLI
- OCI hesabı ve API Key

### Başlangıç

```bash
# 1. Repo'yu klonla
git clone https://github.com/Syenta-Elf/oci-k8s-terraform.git
cd oci-k8s-terraform/Part-2/oci-infra

# 2. OCI CLI'ı konfigüre et
oci setup config

# 3. terraform.tfvars oluştur
cp terraform.tfvars.example terraform.tfvars
# Değerleri doldur

# 4. Başlat
terraform init
terraform plan
terraform apply
```

### terraform.tfvars Örneği

```hcl
region           = "eu-frankfurt-1"
tenancy_ocid     = "ocid1.tenancy.oc1..xxx"
user_ocid        = "ocid1.user.oc1..xxx"
fingerprint      = "xx:xx:xx:xx"
private_key_path = "~/.oci/oci_api_key.pem"
bucket_name      = "terraform-state"
bucket_namespace = "your-namespace"
```

---

## 📝 Notlar

- Free Tier A1 instance kapasitesi Frankfurt'ta yoğun dönemlerde dolabilir. Node pool oluşturulamazsa kapasite açılana kadar beklemek gerekir.
- `terraform.tfvars` dosyası `.gitignore`'a eklidir — asla commit etme.
- Remote state OCI Object Storage'da saklanır, state locking desteklenir.
