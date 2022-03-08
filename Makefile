backports:
	echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
	sudo apt update

dev-dispvm: extrepo-vscodium
	sudo apt install --yes \
		codium \
		git \
		python3-venv \
		python3-dev \
		python3-tk \
		vim \
		xvfb

extrepo: backports
	sudo apt install --yes extrepo
	sudo apt update

extrepo-vscodium: extrepo
	sudo extrepo enable vscodium
	sudo apt update
