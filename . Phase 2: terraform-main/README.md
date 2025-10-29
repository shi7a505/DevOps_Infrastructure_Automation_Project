# Phase 2: Main Infrastructure - Create DevOps Server EC2

This phase provisions the main DevOps Server EC2 instance on AWS from the Terraform Controller created in Phase 1.

## Steps

1. SSH into the Terraform Controller EC2 instance (created in Phase 1):
    ```bash
    ssh -i <your-key.pem> ec2-user@<controller-public-ip>
    ```

2. Go to the terraform-main directory:
    ```bash
    cd terraform-main
    ```

3. Initialize Terraform:
    ```bash
    terraform init
    ```

4. Apply the configuration to provision the DevOps Server EC2:
    ```bash
    terraform apply
    ```
    - Review the plan and confirm.
    - Wait for the instance to be provisioned.

## Outputs

- You will get the public/private IPs of the DevOps Server EC2 instance.
- This instance will be configured further using Ansible in the next phase.

## Notes

- Ensure network/security group settings allow connectivity between the controller and DevOps Server.
- SSH key configuration should match the resources created in Phase 1.
