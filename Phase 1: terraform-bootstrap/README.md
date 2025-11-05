# Phase 1: Bootstrap - Create Terraform Controller EC2

This phase creates a dedicated EC2 instance (Terraform Controller) on AWS that will be used to manage and apply the main infrastructure.

## Steps

1. Make sure you have AWS CLI and Terraform installed locally, and your AWS credentials are configured.

2. Initialize Terraform:
    ```bash
    terraform init
    ```

3. Apply the configuration to create the controller EC2 instance:
    ```bash
    terraform apply
    ```
    - Review the plan and confirm.
    - Wait for the instance to be provisioned.

## Outputs

- After successful apply, you will get the public IP of the controller EC2 instance.
- Use this IP to connect via SSH in the next phase.

## Notes

- The Terraform Controller acts as a jump host to apply further infrastructure.
- Make sure your SSH key pair is available and referenced correctly in the configuration.

---
