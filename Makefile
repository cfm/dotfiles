backports:
	echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
	sudo apt update

extrepo: backports
	sudo apt install --yes extrepo
	sudo apt update

extrepo-vscodium: extrepo
	sudo extrepo enable vscodium
	sudo apt update

terraform-apt:  # adapted from https://www.terraform.io/downloads
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	echo "deb [arch=amd64] https://apt.releases.hashicorp.com `lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/terraform.list
	sudo apt update

sd-dev: extrepo-vscodium prereqs terraform-apt
	sudo apt install --yes \
		codium \
		git git-lfs \
		jq \
		python3-venv \
		python3-dev \
		python3-tk \
		sqlite3 \
		terraform \
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
	sudo apt install --yes \
		python3-pip \
		virtualenvwrapper

prereqs:
	sudo apt update
	sudo apt install scdaemon

sd-staging:
	sudo apt install qubes-core-admin-client
