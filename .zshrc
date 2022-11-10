# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Zsh theme by p10k.
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Download Znap, if it's not there yet.
[[ -f $HOME/.znap/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $HOME/.znap/zsh-snap

source $HOME/.znap/zsh-snap/znap.zsh  # Start Znap

# Install zsh plugins by Znap
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source agkozak/zsh-z
znap source zsh-users/zsh-completions

# Setup zsh-completions 
fpath=($HOME/.znap/zsh-completions/src $fpath)
autoload -Uz compinit && compinit

source $HOME/.aliases
source /usr/share/nvm/init-nvm.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
