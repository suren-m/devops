# Ansible Playbooks for Dev environment automation

---
## WSL2 Debian

1. Install `git, wget, ansible` from `prereq/wsl2_debian/init.sh`
2. Clone this `repo`
2. Run `ansible-playbook wsl2_init.yml`
3. Reload shell `source ~/.zshrc` so the env_vars and config are applied
4. Run `ansible-playbook wsl.yml`
5. For `vs code` and `windows_terminal` configs, see `config_files` directory

---