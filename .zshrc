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
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source marlonrichert/zsh-autocomplete
znap source agkozak/zsh-z
znap source zsh-users/zsh-completions
# # Setup zsh-completions
fpath=($HOME/.znap/zsh-completions/src $fpath)
autoload -Uz compinit && compinit

# History in cache directory:
HISTFILE=$HOME/.history
HISTSIZE=10000
SAVEHIST=10000
# 不保留重复的历史记录项
setopt hist_ignore_all_dups
# 在命令前添加空格，不将此命令添加到记录文件中
setopt hist_ignore_space
# zsh 4.3.6 doesn't have this option
setopt hist_fcntl_lock 2>/dev/null
setopt hist_reduce_blanks

source $HOME/.aliases
source /usr/share/nvm/init-nvm.sh

export FZF_COMPLETION_TRIGGER='ll'
# 搜索文件时改成 fd 搜索且允许搜索隐藏文件
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# 下面这个文件是 fzf 安装期间自动生成的，不用改
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
