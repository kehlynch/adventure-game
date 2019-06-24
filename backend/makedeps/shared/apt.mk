.PHONY: apt-update
apt-update: ## run apt update, this will first call the meta target repos, to make sure all make recipes apt repos are added
	@sudo apt-get update -qq

.PHONY: apt-install
apt-install: ## install package, pass the package name in via 'apt-install packages="name"'
	@sudo apt-get install -y $(packages);

.PHONY: apt-repo
apt-repo: ## add repository to /etc/apt/sources.list.d/, e.g. usage 'apt-repo url="https://repo.org" codename="stable" components="main" name="repo"'
	@$(MAKE) -s output-blue text="installing repository $(url) $(codename) $(components)"
	@echo "deb $(url) $(codename) $(components)" | sudo tee /etc/apt/sources.list.d/$(name).list > /dev/null 2>&1

.PHONY: apt-ppa
apt-ppa: ## add apt ppa, e.g. 'apt-ppa ppa="ppa:user/project"'
	@echo "adding ppa $(ppa)"
	@sudo apt-add-repository -y $(ppa) > /dev/null 2>&1

.PHONY: apt-add-key
apt-add-key: ## add apt gpg key to key chain, e.g. 'apt-add-key url="https://repo.org/repo_gpg_key"'
	curl -SLo temp.key $(url) > /dev/null 2>&1
	key=$$(gpg temp.key | awk '{print $$3}' | head -1); \
	if [[ -z "$$(sudo apt-key list | grep "$$key")" ]] ;\
	then \
		cat temp.key | sudo apt-key add - > /dev/null 2>&1;\
  fi
	rm temp.key
