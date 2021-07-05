# Ansible Playbooks for Dev environment automation

---
## WSL2 Debian Example

1. Install `git, wget, ansible` via `prereq/wsl2_debian/init.sh`
2. Clone this `repo`
2. Run `ansible-playbook phase1.yml`
    * Variables are located in `./vars` directory
        * For e.g: `remove_existing` for `go` task is in `programming.yml`
    * Global vars such as `os` and `arch` are located in `inventory/group_vars/`
3. Set `zsh` as default shell (see: https://wiki.debian.org/Zsh)
    * zsh
    * chsh -s /bin/zsh
    * Reload shell with `source ~/.zshrc`
4. Run `ansible-playbook phase2.yml`
5. For `vs code` and `windows_terminal` configs, see `config_files` directory

---


