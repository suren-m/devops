# Ansible Playbooks for Dev environment automation

## Azure VM Example

```
# static inventory example
ansible-playbook -i inventory/cloud phase1.yml --check
```
#### See github workflow for more details (ensure the self-hosted runner has access to target VMs to execute playbooks)

---
## WSL2 Debian Example

## Init 
1. Install `git, wget, ansible` via `prereq/wsl2_debian/init.sh`
2. Clone this `repo`

## Phase 1
1. Run `ansible-playbook phase1.yml`
    * Variables are located in `./vars` directory
        * For e.g: `remove_existing` for `go` task is in `programming.yml`
    * Global vars such as `target.platform` and `target.arch` are located in `inventory/group_vars/`
2. Set `zsh` as default shell for current user (see: https://wiki.debian.org/Zsh)    
    * sudo chsh -s $(which zsh) $(whoami)     
    * Verify with `grep $USER /etc/passwd`       
3. Exit and Restart Terminal (not just `source ~/.zshrc`)
    * This is because `homebrew's` env_vars are loaded via `.profile` or `.zprofile` 

## Phase 2
1. Install ansible-galaxy co
1. Run `ansible-playbook phase2.yml` 
    * Tools in phase2 require tools from phase1 such as `cargo` and `go` available in shell.
2. For `vs code` and `windows_terminal` configs, see `config_files` directory

---


#### Ansible on Azure (credentials file)

Values shouldn't contain quotation marks

```
[default]
subscription_id=....
client_id=...
secret=...
tenant=...
```

