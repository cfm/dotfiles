# --- WHOLES ---

dotfiles:
	git clone git@github.com:cfm/dotfiles.private.git

dvm: dev vscodium
	sudo apt-get --yes autoremove

sd-dev: dev terraform vscodium
	sudo apt-get --yes autoremove

sd-staging: prereqs
	sudo apt install --yes qubes-core-admin-client
	sudo apt-get --yes autoremove


# --- PIECES ---

dev: prereqs
	sudo apt install --yes \
		git git-lfs \
		jq \
		mr perl-doc \
		python3-venv \
		python3-dev \
		python3-tk \
		sqlite3 \
		vim \
		vinagre \
		xvfb
	# https://docs.securedrop.org/en/stable/development/setup_development.html#id1
	sudo apt install --yes \
		build-essential \
		libssl-dev \
		libffi-dev \
		python3-dev \
		dpkg-dev \
		git \
		linux-headers-$(uname -r)
	sudo apt install --yes podman
	sudo apt install --yes \
		python3-pip \
		virtualenvwrapper

extrepo:
	sudo apt install --yes extrepo
	sudo apt update

terraform: terraform-repo
	sudo apt install --yes terraform

terraform-repo:  # adapted from https://www.terraform.io/downloads
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	echo "deb [arch=amd64] https://apt.releases.hashicorp.com `lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/terraform.list
	sudo apt update

prereqs:
	sudo apt update
	sudo apt install scdaemon

vscodium: vscodium-repo
	sudo apt install --yes codium

vscodium-repo: extrepo
	sudo extrepo enable vscodium
	sudo apt update
