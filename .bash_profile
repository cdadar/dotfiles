# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
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

# Initialization for FDK command line tools.Wed Mar 23 11:02:58 2016
FDK_EXE="/home/chen/bin/FDK/Tools/linux"
PATH=${PATH}:"/home/chen/bin/FDK/Tools/linux"
export PATH
export FDK_EXE

[ -s "/home/chen/.dnx/dnvm/dnvm.sh" ] && . "/home/chen/.dnx/dnvm/dnvm.sh" # Load dnvm
