### GCP VM Setting
- Region/ Zone: Iowa (us-central1), any zone
- Machine Type: e2-standard-4 → 4 vCPUs, 16 GB RAM (general-purpose)
- Operating System: Ubuntu 22.04 (64-bit)
- Boot Disk: 30 GB Balanced Persistent Disk (SSD, good balance of performance and cost)

### Remote Connect to GCP VM via SSH
1. Generate SSH Key Pair<br>
Follow the guide here: https://cloud.google.com/compute/docs/connect/create-ssh-keys#linux-and-macos
2. Add Your Public Key to GCP Metadata<br>
    - After generating the SSH key, run
    ```
    cat ~/.ssh/your_key.pub
    ```
    - Copy the full output, then
        Go to GCP Console → Compute Engine → Metadata → SSH Keys tab
3. Connect to the VM using Visual Studio Code
    - Open Visual Studio Code and use the Remote - SSH extension
    - For the Host, enter the external IP address of your GCP VM
    - Use your Google username (e.g., yourname@gmail.com) as the SSH user

### Tip to save cost
To reduce cost, remember to `stop` or `suspend` the VM when not in use, will be charged for the disk, but CPU and RAM usage will not be billed while the VM is stopped. 

`Stop`: Resets the VM – better for cost saving over long idle period.<br>
`Suspend`: Saves the VM`s session – good if want to quickly resume with the same session/ state.