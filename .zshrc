# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

ZSH_THEME="powerlevel10k/powerlevel10k"

export DEFAULT_USER="$USER"
export TERM="xterm-256color"
export ZSH=/usr/share/oh-my-zsh
# /!\ do not use with zsh-autosuggestions

plugins=(archlinux
	asdf
	bundler
	docker
	jsontools
	vscode
	web-search
	tig
	gitfast
	colored-man-pages
	colorize
	command-not-found
	cp
	dirhistory
	sudo
	fzf
	zsh-syntax-highlighting
  	zsh-autosuggestions
	)
# /!\ zsh-syntax-highlighting and then zsh-autosuggestions must be at the end

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi
source /usr/share/nvm/init-nvm.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
