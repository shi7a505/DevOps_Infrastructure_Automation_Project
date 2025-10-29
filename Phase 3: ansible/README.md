# Phase 3: Configure DevOps Server with Ansible

This phase installs Jenkins and other required applications on the DevOps Server EC2 instance provisioned in Phase 2.

## Steps

1. Ensure Ansible is installed and you have SSH access to the DevOps Server.

2. Go to the ansible directory:
    ```bash
    cd ansible
    ```

3. Edit the inventory file to include the DevOps Server IP:
    - Open `inventory.ini` and set the correct public IP for the DevOps Server.

4. Run the Ansible Playbook to install Jenkins:
    ```bash
    ansible-playbook -i inventory.ini install-jenkins.yml
    ```

## Outputs

- Jenkins and any other configured applications will be installed on the DevOps Server.
- Access Jenkins via the server's public IP and the configured port.

## Notes

- You can extend the playbook to install other tools or configure additional services.
- Make sure your SSH key is correctly referenced in the inventory or Ansible config.
