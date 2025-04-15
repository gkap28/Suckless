#####---------- EXPORTS ----------###
export BROWSER="Brave"
export EDITOR="nvim -u $HOME/.config/nvim/init.lua"
export VISUAL="nvim -u $HOME/.config/nvim/init.lua"
#export MYVIMRC="$HOME/.config/vim/.vimrc"
#export VIMINIT="source $MYVIMRC"
export LESSHISTFILE=-
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORM=xcb
export PATH="$PATH:$HOME/.local/scripts/:$HOME/.local/.bin/:$HOME/.local/scripts/dmenu/:$HOME/.bin/:$HOME/.local/fzfm"
export CDPATH=".:$HOME:$HOME/.config/:$HOME/.local/:$HOME/.local/share/:$HOME/.local/programms"
export CSCOPE_EDITOR="nvim"
#export HYPRSHOT_DIR="$HOME/Images/Pictures/Screenshots"
export INPUTRC=/home/georg/.inputrc
#export GIT_CONFIG_GLOBAL=/home/jake/.config/git/gitconfig
precmd() { print "" }
autoload -U compinit
autoload -Uz promptinit
setopt autocd
cdpath=(/ $HOME/.config) 
setopt PROMPT_SUBST
compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
HISTFILE=~/.zsh_history
SAVEHIST=1000000000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY


source $HOME/.config/zsh/plugins/zsh-autosuggestions-master/zsh-autosuggestions.zsh
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# /Users/georg65/.oh-my-zsh/custom/plugins/zsh-autosuggestions

###------------------- PROMPT -----------------------###
function parse_git_dirty { STATUS="$(git status 2> /dev/null)"
  if [[ $? -ne 0 ]]; then printf ""; return; else printf " ["; fi
  if echo "${STATUS}" | grep -c "renamed:"         &> /dev/null; then printf " >"; else printf ""; fi
  if echo "${STATUS}" | grep -c "branch is ahead:" &> /dev/null; then printf " !"; else printf ""; fi
  if echo "${STATUS}" | grep -c "new file::"       &> /dev/null; then printf " +"; else printf ""; fi
  if echo "${STATUS}" | grep -c "Untracked files:" &> /dev/null; then printf " ?"; else printf ""; fi
  if echo "${STATUS}" | grep -c "modified:"        &> /dev/null; then printf " *"; else printf ""; fi
  if echo "${STATUS}" | grep -c "deleted:"         &> /dev/null; then printf " -"; else printf ""; fi
  printf " ]"
}

parse_git_branch() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

PROMPT='%B%F{003}  %B%F{015}%~%B%F{006}  %b%F{015} '
RPROMPT='%B%F{006}$(parse_git_branch)%F{003}$(parse_git_dirty) %B%F{015}%T%B%b%f'


alias ls='eza -bghHliSa'
alias c='clear'
alias dwmc='sudo nvim ~/.config/suckless/dwm/config.def.h'
alias make='sudo rm -rf config.h && sudo make clean install'
alias stc='nvim ~/.config/suckless/st/config.def.h'
alias term='nvim ~/.config/alacritty/alacritty.toml'
alias sz='source $HOME/.config/zsh/.zshrc'
alias merge="xrdb -merge $HOME/.Xresources"

alias upgrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias s="subl"
alias ss="sudo subl"

alias zsh='nvim ~/.config/zsh/.zshrc'
alias pinst='sudo pacman -S'
alias yinst='sudo yay -S'
alias rem='sudo rm -rf'
alias find='find /. -name 2> /dev/null'
alias r='ranger'

##########VOIDLINUX############
alias xi="sudo xbps-install -S"
alias xs="sudo xbps-query -Rs"
alias up="sudo xbps-install -u xbps; sudo xbps-install -Su"
alias xr="sudo xbps-remove -Rs"


# eval "$(zoxide init zsh)"
# eval "$(zoxide init --cmd cd zsh)"
