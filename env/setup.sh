#!/bin/bash

#mv $HOME/.bashrc $HOME/.bashrc.orig

# Generate SSH Key
cat /dev/zero | ssh-keygen -q -N ""

# Generate GPG keyring
cat >foo <<EOF
     %echo Generating a basic OpenPGP key
     Key-Type: default
     Key-Length: 2048
     Subkey-Type: default
     Name-Real: Rory MacGregor
     Name-Comment: with stupid passphrase
     Name-Email: rorymacgregor88@outlook.com
     Expire-Date: 0
     Passphrase: abc
     # Do a commit here, so that we can later print "done" :-)
     %commit
     %echo done
EOF
gpg --batch --generate-key foo
rm -rf foo

# Setup oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Setup static files.
# Delete existing files
rm -rf $HOME/.profile\
       $HOME/.bashrc \
       $HOME/.emacs \
       $HOME/.emacs.d \
       $HOME/.gitconfig \
       $HOME/.gitmessage \
       $HOME/.gitignore \
       $HOME/.vimrc \
       $HOME/.inputrc \
       $HOME/.zshrc \
       $HOME/.fonts \
       $HOME/.k5login \
       $HOME/.oh-my-zsh/themes/rory-macgregor-agnoster.zsh-theme \
       $HOME/.m2 \
       $HOME/.tmux.conf \
       $HOME/.ackrc \
       $HOME/.ssh/config

# Recreate from configured.
ln -s $HOME/.environment/env/profile $HOME/.profile
ln -s $HOME/.environment/env/bashrc $HOME/.bashrc
ln -s $HOME/.environment/env/emacs $HOME/.emacs
ln -s $HOME/.environment/env/emacs.d $HOME/.emacs.d
ln -s $HOME/.environment/env/gitconfig $HOME/.gitconfig
ln -s $HOME/.environment/env/gitmessage $HOME/.gitmessage
ln -s $HOME/.environment/env/gitignore $HOME/.gitignore
ln -s $HOME/.environment/env/vimrc $HOME/.vimrc
ln -s $HOME/.environment/env/inputrc $HOME/.inputrc
ln -s $HOME/.environment/env/zshrc $HOME/.zshrc
ln -s $HOME/.environment/env/fonts $HOME/.fonts
ln -s $HOME/.environment/env/k5login $HOME/.k5login
ln -s $HOME/.environment/env/rory-macgregor-agnoster.zsh-theme $HOME/.oh-my-zsh/themes/rory-macgregor-agnoster.zsh-theme
ln -s $HOME/.environment/env/m2 $HOME/.m2
ln -s $HOME/.environment/env/tmux.conf $HOME/.tmux.conf
ln -s $HOME/.environment/env/ackrc $HOME/.ackrc
ln -s $HOME/.environment/env/config $HOME/.ssh/config
ln -s $HOME/.environment/env/shell_aliases $HOME/.shell_aliases
ln -s $HOME/.environment/env/shell_secrets $HOME/.shell_secrets

# Setup pathogen for vim.
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

## Add vim plugins
cd ~/.vim/bundle
git clone git://github.com/altercation/vim-colors-solarized.git
git clone git://github.com/tpope/vim-sensible.git

# Add TMUX Plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add Node Version manager
git clone https://github.com/nodenv/nodenv.git ~/.nodenv
# Add node-build plugin for ndenv
mkdir -p ~/.nodenv/plugins
git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build

chsh `whoami` -s /bin/zsh
