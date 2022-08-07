#----------------------------------------
# Install app
eval "$(starship init zsh)"
eval "$(zoxide init --cmd j zsh)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#----------------------------------------
# env
export BAT_THEME=zenburn
export EDITOR=kak
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';

#----------------------------------------
# alias
alias .2=cd ../..
alias .3=cd ../../..
alias .4=cd ../../../..
alias .5=cd ../../../../..
alias cat='bat --paging=never'
alias cut='choose'
alias df='duf'
alias diff='delta'
alias du='dust'
alias find='fd'
alias grep='rg'
alias less='bat'
alias ll='lsd -Ahl --total-size --group-dirs=last'
alias lr='lsd -Ahl --total-size --tree --group-dirs=last'
alias ls='lsd -A --group-dirs=last'
alias mkdir='mkdir -p'
alias ps='procs --tree'
alias rd='rmdir'
alias top='btm'
alias tree='lsd -A --tree --group-dirs=last'
alias vi='kak'
alias -g C='|tee >(pbcopy)'
alias -g G='|rg'
alias -g L='|bat --style=plain'
ch() { cheat $* | bat --style=plain -l sh }
jgrep() { gron | grep $* | gron -u }
mkcd() {
    if [[ -d "$1" ]]; then
        cd "$1"
    else
        mkdir -p "$1" && cd "$1"
    fi
}

#----------------------------------------
# history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt histignorealldups
setopt share_history
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
function select-history() {
    BUFFER=$(history -Dinr 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > " | choose 3:)
    CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

#----------------------------------------
# cd
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
chpwd() { lsd -d */ --icon never }

#----------------------------------------
# completion
autoload -U compinit && compinit
setopt menu_complete
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu true select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
