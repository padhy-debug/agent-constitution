# Terraform & OpenTofu Standards & Conventions

Applies whenever the project uses Terraform or OpenTofu for Infrastructure as Code (IaC).

---

## 1. Tooling & Environment Management

- **Version Pinning**:
  - Always pin exact Terraform/OpenTofu binary constraints and provider versions in `versions.tf`:
    ```hcl
    terraform {
      required_version = ">= 1.7.0"
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.40"
        }
      }
    }
    ```
- **Static Analysis & Security Scanning**:
  - Run `terraform fmt -check` to verify canonical formatting.
  - Run `terraform validate` during CI pipelines.
  - Scan for security misconfigurations and CVEs using **tflint**, **trivy**, or **checkov**.
- **Remote State Management**:
  - Never store `.tfstate` in git repositories. Remote state backends (S3 + DynamoDB locking, GCS, Terraform Cloud) with encryption and state locking are mandatory.

---

## 2. Module Architecture & Design

- **Directory Structure**:
  - Split infrastructure into distinct environments (`environments/dev`, `environments/prod`) and reusable modules (`modules/networking`, `modules/database`).
  - Standard files per module:
    - `main.tf`: Core resource definitions.
    - `variables.tf`: Explicit input variable definitions with types and descriptions.
    - `outputs.tf`: Explicit output definitions with descriptions.
    - `versions.tf`: Provider and runtime version constraints.
- **Variable Hygiene**:
  - Every variable must have an explicit `type` (e.g., `string`, `list(string)`, `map(any)`).
  - Sensitive variables must be flagged with `sensitive = true`.
- **Data Sources vs. Resource References**:
  - Within a single state module, reference resources directly via attribute syntax (`aws_subnet.primary.id`).
  - Use `data` sources exclusively for external resources outside the current state boundary.

---

## 3. Safe Execution & Zero-Data-Loss Guardrails

- **Blast Radius & Plan Review**:
  - Never execute `terraform apply` blindly. Always generate and inspect a planned execution file:
    ```bash
    terraform plan -out=tfplan
    terraform apply tfplan
    ```
- **Resource Destruction Protections**:
  - Stateful resources (databases, storage buckets, DNS zones) must include lifecycle protection:
    ```hcl
    lifecycle {
      prevent_destroy = true
      ignore_changes  = []
    }
    ```
  - Zero destructive changes (`destroy` actions) in automated CI without explicit interactive gate approval.

---

## 4. Testing & Verification

- **Automated Testing**: Use native `terraform test` (Terraform 1.6+) for HCL integration tests, or **Terratest** (Go) for comprehensive end-to-end ephemeral provisioning checks.
- **Pre-flight Tripwires**: Ensure all input variables have sensible defaults or fail with clear invariant messages if required environment variables are absent.
