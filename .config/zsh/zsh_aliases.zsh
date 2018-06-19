# Convenience aliases for common commands
alias 'mirrors'='sudo pacman-mirrors --fasttrack && sudo pacman -Syy'
alias 'battery'='if [ -f /sys/class/power_supply/BAT1/charge_now ] ; then ((echo "Battery: " ; ((echo "scale=4;" ; cat /sys/class/power_supply/BAT1/charge_now ; echo / ; cat /sys/class/power_supply/BAT1/charge_full) | tr -d '"'"'\n'"'"' ; echo "*100") | bc | tr -d '"'"'\n'"'"' | perl -pe '"'"'s/(\d*)((\.|(\.\d+?))0*)?$/\1\4/gp'"'"') | tr -d '"'"'\n'"'"'; echo "%") ; (if [ -f /sys/class/power_supply/BAT1/status ] ; then echo " - Status: `cat /sys/class/power_supply/BAT1/status`" ; fi)else echo "No battery" ; fi'
alias 'vim'='nvim'
alias 'dotln'='ln -s ~/Downloads/dotfiles/$FILE ~/$FILE'
alias 'backup'='rsync -ra --progress'
alias 'lyrics'='kid3-cli -c "get lyrics"'
