#!/bin/bash
# setup xsub on K-login
target_ver="2.4.3"

if [ "x`which xsub`" != "x" ]; then
    exit 0
fi

# clone xsub
git clone https://github.com/crest-cassia/xsub.git $HOME/xsub

# setup Ruby with rbenv
git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bash_profile
$HOME/.rbenv/bin/rbenv init
source  $HOME/.bash_profile

git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
export PREFIX=$HOME/opt
$HOME/.rbenv/plugins/ruby-build/install.sh

rbenv install $target_ver
echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile
source  $HOME/.bash_profile

rbenv global $target_ver

# module load for Ruby
echo 'module load GCC/6.3.0-gnu-x86' >> $HOME/.bash_profile
echo 'export XSUB_TYPE="k"' >> $HOME/.bash_profile
echo 'export PATH="$PATH:$HOME/xsub/bin"' >> $HOME/.bash_profile

rm -f $HOME/ruby-build.*.*.log
exit 0
