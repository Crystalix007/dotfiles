# Convenience aliases for common commands
alias 'apt-search'='pacman -Qs'
alias 'apt-update'='pacman -Sy'
alias 'apt-force-update'='pacman -Syy'
alias 'apt-install'='pacman -S'
alias 'apt-clean'='pacman -Sc'
alias 'mirrors'='sudo pacman-mirrors --fasttrack && sudo pacman -Syy'
alias 'battery'='(echo "Battery: " ; ((echo "scale=3;" ; cat /sys/class/power_supply/BAT1/charge_now ; echo / ; cat /sys/class/power_supply/BAT1/charge_full) | tr -d '"'"'\n'"'"' ; echo "*100") | bc | tr -d '"'"'\n'"'"' | perl -pe '"'"'s/(\d*)((\.\d*?)0*)?$/\1\3/gp'"'"') | tr -d '"'"'\n'"'"'; echo "%"'
