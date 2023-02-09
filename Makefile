$(eval $(shell grep VERSION_CODENAME /etc/os-release))

# --- WHOLES ---

# Someday I might split out generic versus SecureDrop-specific dependencies (as
# I already do repositories).  But for now just alias:
dev: sd-dev

dotfiles: _key
	git remote set-url origin git@github.com:cfm/dotfiles.git
	test -d dotfiles.private || git clone git@github.com:cfm/dotfiles.private.git

key: _key

sd-dev: dotfiles _dev _docker _terraform _vscodium

sd-dev-dvm: dotfiles _dev _vscodium

sd-build-dvm: dotfiles _docker _prereqs

sd-staging: _prereqs
	sudo apt-get install --yes qubes-core-admin-client
	sudo apt-get --yes autoremove


# --- PIECES ---

_dev: _prereqs
	sudo apt-get install --yes \
		jq \
		perl-doc \
		python3-dev \
		python3-tk \
		sqlite3 \
		vim \
		vinagre \
		xvfb

_docker: _docker-repo
	sudo apt-get update
	sudo apt-get install --yes docker-ce docker-ce-cli containerd.io
	sudo usermod -G docker -a $(shell whoami)

_docker-repo:
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

_extrepo:
	sudo apt-get install --yes extrepo
	sudo apt-get update

_key: _prereqs
	gpg --recv-key 0x0F786C3435E961244B69B9EC07AD35D378D10BA0
	chmod 700 ~/.gnupg
_rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

_terraform: _terraform-repo
	sudo apt-get install --yes terraform

_terraform-repo:  # adapted from https://www.terraform.io/downloads
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	echo "deb [arch=amd64] https://apt.releases.hashicorp.com `lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/terraform.list
	sudo apt-get update

_prereqs: _prereqs-sd _rust
ifdef VERSION_CODENAME
	sudo apt-get update
	sudo apt-get autoremove --yes
	sudo apt-get install --yes \
		git git-lfs mr \
		python3-venv libpython3-dev \
		rsync \
		scdaemon
endif

_prereqs-sd:  # https://docs.securedrop.org/en/stable/development/setup_development.html#id1
ifdef VERSION_CODENAME
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
endif

_vscodium: _vscodium-repo
	sudo apt-get install --yes codium

_vscodium-repo: _extrepo
	sudo extrepo enable vscodium
	sudo apt-get update
