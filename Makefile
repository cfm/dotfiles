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

sd-dev: extrepo-vscodium terraform-apt
	sudo apt install --yes \
		codium \
		git \
		jq \
		python3-venv \
		python3-dev \
		python3-tk \
		terraform \
		vim \
		vinagre \
		xvfb
