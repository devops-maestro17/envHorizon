# Automating Infrastructure Deployment on AWS Using Terraform

### This Terraform project deploys the following infrastructure on AWS:

* A custom VPC having two public and private subnets in each AZ. It also has an internet gateway deployed to enable internet traffic within the VPC and route table to which the public subnets are associated.
  
* EC2 instance servers are deployed within the public subnets along with security groups attached to them to enable inbound traffic.

* An elastic load balancer is created to distribute the incoming traffic across the servers.

* An RDS instance is created within the private subnets.


### Apart from the infrastructure, this project also implements the following Terraform features:

* **Modularity**: Terraform modules are used to build separate components for compute, networking, storage, etc.

* **Flexibility**: Terraform variables, outputs, and tfvars are used to enable more flexible and modular code by avoiding hard-coded values.

* **Remote Backend**: S3 bucket is configured as a remote backend for storing the Terraform statefile.

* **Multiple Environments**: The infrastructure can be deployed to multiple environments (dev, staging & prod) with the help of separate subdirectories and backends for each environment.

* **Static Checks**: Static checks using `terraform fmt`, `terraform validate`, and `terraform plan` are performed to check the formatting, validate configurations, and compare the desired state with the actual state, respectively.

* **State Locking**: State locking using DynamoDB is added to prevent concurrent updates and preventing other users from acquiring lock and potentially corrupting the state.

* **Secrets Management**: Secrets are managed using Hashicorp Vault and the database credentials are stored securely in the vault.

## Project Structure

The project is structured in the following way to manage multiple environments (dev, staging and production) as subdirectories
```bash

├── development
│   ├── backend.tf
│   ├── main.tf
│   ├── terraform.tfvars
│   └── variables.tf
├── production
│   ├── backend.tf
│   ├── main.tf
│   ├── terraform.tfvars
│   └── variables.tf
├── staging
│   ├── backend.tf
│   ├── main.tf
│   ├── terraform.tfvars
│   └── variables.tf
└── modules
    ├── compute
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── userdata.sh
    │   └── variables.tf
    ├── database
    │   ├── main.tf
    │   └── variables.tf
    ├── hashicorp-vault
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── load-balancer
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── networking
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── s3
    │   ├── main.tf
    │   └── variables.tf
    └── statelock
        └── main.tf
```

## Usage

### Setting up HashiCorp Vault

**Create an AWS EC2 instance with Ubuntu**

To create an AWS EC2 instance with Ubuntu, you can use the AWS Management Console or the AWS CLI. Here are the steps involved in creating an EC2 instance using the AWS Management Console:

- Go to the AWS Management Console and navigate to the EC2 service.
- Click on the Launch Instance button.
- Select the Ubuntu Server xx.xx LTS AMI.
- Select the instance type that you want to use.
- Configure the instance settings.
- Click on the Launch button.

**Install Vault on the EC2 instance**

To install Vault on the EC2 instance, you can use the following steps:

**Install gpg**

```
sudo apt update && sudo apt install gpg
```

**Download the signing key to a new keyring**

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

**Verify the key's fingerprint**

```
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
```

**Add the HashiCorp repo**

```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

```
sudo apt update
```

**Install Vault**

```
sudo apt install vault
```

**Start Vault**

To start Vault, you can use the following command:

```
vault server -dev -dev-listen-address="0.0.0.0:8200"
```

**Configure Terraform to read the secret from Vault**

Detailed steps to enable and configure AppRole authentication in HashiCorp Vault:

1. **Enable AppRole Authentication**:

To enable the AppRole authentication method in Vault, we need to use the Vault CLI or the Vault HTTP API.

**Using Vault CLI**:

Run the following command to enable the AppRole authentication method:

```bash
vault auth enable approle
```

This command tells Vault to enable the AppRole authentication method.

2. **Create a Policy**:

```

vault policy write terraform - <<EOF
path "*" {
  capabilities = ["list", "read"]
}

path "kv/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

EOF
```

Now, we need to create an AppRole with appropriate policies and configure its authentication settings. Here are the steps to create an AppRole:

3. **Create the AppRole**:

```bash
vault write auth/approle/role/terraform \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    token_policies=terraform
```

4. **Generate Role ID and Secret ID**:

After creating the AppRole, we need to generate a Role ID and Secret ID pair. The Role ID is a static identifier, while the Secret ID is a dynamic credential.

**a. Generate Role ID**:

Retrieve the Role ID using the Vault CLI:

```bash
vault read auth/approle/role/my-approle/role-id
```

Save the Role ID for use in the Terraform configuration.

**b. Generate Secret ID**:

To generate a Secret ID, use the following command:

```bash
vault write -f auth/approle/role/my-approle/secret-id
   ```

This command generates a Secret ID and provides it in the response. Save the Secret ID securely, as it will be used for Terraform authentication.


### Deploying the infrastructure

To deploy the infrastructure to a particular environment (ex. dev), configure the variables in the `terraform.tfvars` file present inside the environment directory and use the below command:

```
cd dev/
terraform apply
```

The Vault variables `vault_address`, `vault_role_id`, `vault_secret_id` can be configured inside tfvars file or can be passed at runtime
