# oci-k8s-terraform

Kubernetes cluster deployment on Oracle Cloud Infrastructure (OCI) using Terraform, with a fully automated CI/CD pipeline via GitHub Actions.

![Terraform](https://img.shields.io/badge/Terraform-v1.14-623CE4?logo=terraform)
![OCI](https://img.shields.io/badge/Oracle_Cloud-Infrastructure-F80000?logo=oracle)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?logo=github-actions)

---

## 📁 Project Structure

```
oci-k8s-terraform/
├── Part-1/                    # Terraform fundamentals
│   ├── tf-playground-1/       # init, plan, apply
│   ├── tf-playground-2/       # variables, tfvars
│   └── tf-playground-3/       # outputs, state
└── Part-2/
    └── oci-infra/             # OCI infrastructure
        ├── modules/
        │   ├── network/       # VCN, Subnet, IGW, Route Table
        │   └── oke/           # OKE Cluster, Node Pool
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── providers.tf
```

---

## 🏗️ Architecture

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

## 🛠️ Technologies Used

- **Terraform** v1.14 — Infrastructure as Code
- **Oracle Cloud Infrastructure (OCI)** — Cloud provider
- **OKE** — Oracle Kubernetes Engine
- **GitHub Actions** — CI/CD pipeline
- **OCI Object Storage** — Remote Terraform state backend

---

## 📚 Part-1: Terraform Fundamentals

Hands-on exploration of core Terraform concepts:

- `terraform init`, `plan`, `apply`, `destroy`
- `resource`, `variable`, `output` blocks
- `terraform.tfstate` and state management
- Passing values via `terraform.tfvars`
- Plan symbols: `+` `-` `~` `-/+`

---

## ☁️ Part-2: OCI Infrastructure

### Provisioned Resources

**Network (modules/network)**

- VCN — Virtual Cloud Network (`10.0.0.0/16`)
- Subnet (`10.0.1.0/24`)
- Internet Gateway
- Route Table (`0.0.0.0/0` → Internet Gateway)

**Compute (modules/oke)**

- OKE Cluster (Kubernetes v1.32.1)
- Node Pool configuration (VM.Standard.A1.Flex — awaiting OCI capacity)

**State Management**

- Remote state stored in OCI Object Storage bucket
- State locking supported out of the box

### Key Concepts Covered

- OCI CLI setup and API Key authentication (Identity Domain)
- Terraform modules — reusable infrastructure components
- `terraform state mv` — moving resources between states
- `terraform import` — bringing existing resources under Terraform management
- Terraform Workspaces — isolated environments
- Remote backend — `oci` backend with OCI Object Storage

---

## 🚀 CI/CD Pipeline

Automatically triggered on every push to the `main` branch.

```
Push to main
    │
    ├── terraform init
    ├── terraform plan    ← Every push / PR
    └── terraform apply   ← Only on push to main
```

### Pipeline Setup

Required GitHub Secrets:

| Secret             | Description                      |
| ------------------ | -------------------------------- |
| `OCI_TENANCY_OCID` | OCI Tenancy OCID                 |
| `OCI_USER_OCID`    | OCI User OCID                    |
| `OCI_FINGERPRINT`  | API Key fingerprint              |
| `OCI_REGION`       | OCI Region (e.g. eu-frankfurt-1) |
| `OCI_PRIVATE_KEY`  | Private key content (.pem)       |

---

## ⚙️ Usage

### Prerequisites

- Terraform >= 1.14
- OCI CLI
- An OCI account with API Key configured

### Getting Started

```bash
# 1. Clone the repository
git clone https://github.com/Syenta-Elf/oci-k8s-terraform.git
cd oci-k8s-terraform/Part-2/oci-infra

# 2. Configure OCI CLI
oci setup config

# 3. Create your tfvars file
cp terraform.tfvars.example terraform.tfvars
# Fill in your values

# 4. Initialize and apply
terraform init
terraform plan
terraform apply
```

### terraform.tfvars Example

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

## 📝 Notes

- Free Tier A1 instance capacity in Frankfurt may be unavailable during peak times. If node pool creation fails, wait for capacity to become available and re-run `terraform apply`.
- `terraform.tfvars` is listed in `.gitignore` — never commit it.
- Remote state is stored in OCI Object Storage with state locking enabled.
