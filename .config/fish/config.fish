# alias
alias p-s='sudo pacman -S'   		# install
alias p-syu='sudo pacman -Syu'		# upgrade, add 'a' to the list of letters to update AUR packages if you use yaourt
alias p-sy='sudo pacman -Sy'		# update
alias p-rsn='sudo pacman -Rns'		# remove
alias p-ss='sudo pacman -Ss'		# search packages
alias p-si='sudo pacman -Si'		# info
alias p-qdt='sudo pacman -Qdt'		# list orphans
alias p-del='p-qdt && sudo pacman -Rns $(sudo pacman -Qtdq)' # remove orphans
alias p-cc='sudo pacman -Scc'		# clean cache
alias p-ql='sudo pacman -Ql'		# list files
alias ls='ls --color=auto'
alias ll='ls -lA --color=auto'
alias mi='sudo -b scrcpy -s 4dcb9ad5 --turn-screen-off'
alias fy='trans -sp'
#alias goto='sudo /opt/gotohttp_gui_x64/gotohttp noboot'
#alias cat='bat --color=always'
#alias diff='delta'
alias myip="curl ifconfig.me/ip && curl ifconfig.me/lang"
# proxy
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:7891"
alias unsetproxy="unset ALL_PROXY"


function fish_greeting
end

function nvm
   bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end


