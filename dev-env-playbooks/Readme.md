# Ansible Playbooks for Dev environment automation

---
## WSL2 Debian

1. Install `git, wget, ansible` from `prereq/wsl2_debian/init.sh`
2. Clone this `repo`
2. Run `ansible-playbook wsl2_init.yml`
    * Variables are located in `./vars` directory
        * For e.g: `remove_existing` for `go` task is in `programming.yml`
    * Global vars such as `os` and `arch` are located in `inventory/group_vars/`
3. Set `zsh` as default shell (see: https://wiki.debian.org/Zsh)
    * zsh
    * chsh -s /bin/zsh
    * Reload shell with `source ~/.zshrc`
4. Run `ansible-playbook post_source.yml`
5. For `vs code` and `windows_terminal` configs, see `config_files` directory

---