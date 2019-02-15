#!/bin/bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.6.3

OS_NAME=$(uname)
case $OS_NAME in

  Linux)
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
    echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
    ;;

  Darwin)
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bash_profile
    echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bash_profile
    ;;
  *)
    echo "This script has not been configured for OS Type: $OS_NAME." 1>&2
    exit 1
    ;;

esac

if [ -f /usr/bin/fish ]
then
    echo 'source ~/.asdf/asdf.fish' >> ~/.config/fish/config.fish
    mkdir -p ~/.config/fish/completions &&  cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions
fi

source ~/.bashrc
asdf plugin-add carnegie https://github.com/Littlejd1997/asdf-kubectl.git
asdf install carnegie eks
asdf install carnegie hub
echo -e "\n\nYou may now switch between kubernetes/helm/minikube versions using

$ asdf global carnegie eks
or
$ asdf global carnegie hub
or via the enviorment variable ASDF_CARNEGIE_VERSION=(eks|hub)"