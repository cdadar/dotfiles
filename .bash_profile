# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f ~/.zshrc ]; then
    . ~/.zshrc
fi


# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin=$PATH:/usr/local/bin


#export http_proxy=127.0.0.1:8118

#postgresql data
#PGDATA=/opt/postgresql/data
#export PGDATA

# steam no runingtime
# export STEAM_RUNTIME=0
#export PATH

[ -s "~/.dnx/dnvm/dnvm.sh" ] && . "~/.dnx/dnvm/dnvm.sh" # Load dnvm


# ssh
export SSH_KEY_PATH="$HOME/.ssh"
ssh-add "$SSH_KEY_PATH/work_rsa"
