$(eval $(shell grep VERSION_CODENAME /etc/os-release))

# --- WHOLES ---

dotfiles: key
	git remote set-url origin git@github.com:cfm/dotfiles.git
	git clone git@github.com:cfm/dotfiles.private.git

sd-dev: dev docker dotfiles terraform vscodium

sd-dev-dvm: dev dotfiles vscodium

sd-build-dvm: docker dotfiles prereqs

sd-staging: prereqs
	sudo apt-get install --yes qubes-core-admin-client
	sudo apt-get --yes autoremove


# --- PIECES ---

dev: prereqs
	sudo apt-get install --yes \
		jq \
		perl-doc \
		python3-dev \
		python3-tk \
		sqlite3 \
		vim \
		vinagre \
		xvfb

docker: docker-repo
	sudo apt-get update
	sudo apt-get install --yes docker-ce docker-ce-cli containerd.io
	sudo usermod -G docker -a $(shell whoami)

docker-repo:
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

extrepo:
	sudo apt-get install --yes extrepo
	sudo apt-get update

key: prereqs
	gpg --recv-key 0x0F786C3435E961244B69B9EC07AD35D378D10BA0
	chmod 700 ~/.gnupg

terraform: terraform-repo
	sudo apt-get install --yes terraform

terraform-repo:  # adapted from https://www.terraform.io/downloads
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	echo "deb [arch=amd64] https://apt.releases.hashicorp.com `lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/terraform.list
	sudo apt-get update

prereqs: prereqs-sd
	sudo apt-get update
	sudo apt-get autoremove --yes
	sudo apt-get install --yes \
		git git-lfs mr \
		python3-venv libpython3-dev \
		rsync \
		scdaemon

prereqs-sd:  # https://docs.securedrop.org/en/stable/development/setup_development.html#id1
	sudo apt-get install --yes \
		build-essential \
		libssl-dev \
		libffi-dev \
		python3-dev \
		dpkg-dev \
		git \
		linux-headers-$(uname -r)
	sudo apt-get install --yes \
		python3-pip \
		virtualenvwrapper

vscodium: vscodium-repo
	sudo apt-get install --yes codium

vscodium-repo: extrepo
	sudo extrepo enable vscodium
	sudo apt-get update
