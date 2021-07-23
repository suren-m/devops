## Configuring VMs on Azure with Ansible

### Dynamic Inventory Example 

### The inventories here re-use the playbooks in [dev-env](https://github.com/suren-m/devops/tree/main/dev-env) directory

```
# Example Run
ansible-inventory -i inventory/linux_azure_rm.yml --graph (or --list)
cd ../../
ansible-playbook dev-env/linux/ansible-playbooks/prereq.yml -i azure-iac/ansible/inventory/linux_azure_rm.yml

# See az-linux-devenv-ansible-playbook.yml for more details
```
---

### Static Inventory Example

```
ansible-playbook -i static_inventory <playbook.yml>
```
---

### One off commands

```
# If `hosts` file is in one of the known locations
ansible all –m ping

# Or pass the inventory file
ansible all -i ./inventory_file -m ping

# Or directly contact a host by IP or hostname. (Notice the use of comma)

ansible all -i 10.0.1.4, -m ping

```
> Pinging a windows machine will require additional details and uses a different module. (see [windows playbooks](https://github.com/suren-m/devops/tree/main/dev-env/windows/ansible-playbooks))

---

### Example Roles from another Repo

```
ansible-galaxy list
ansible-galaxy install git+https://github.com/suren-m/ansible-demo-roles.git
ansible-galaxy remove ansible-demo-roles

```

---


