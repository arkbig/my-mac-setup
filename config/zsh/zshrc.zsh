######################################################################
# general

# BATシンタックスハイライトでチートシート表示するため、#のコメント行を見やすくする
export BAT_THEME=zenburn
# viの代わりにKakouneを使う
export EDITOR=kak
# 補完メニューのカラー変更でも使うため、LSDのデフォルト色を設定
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

######################################################################
# alias
# デフォルト環境に放り出されると戸惑いそうだけど、普段の効率を優先して
# Modern CLI Toolsに置き換える
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
alias grep='rg -S'
alias less='bat'
alias ll='lsd -Ahl --total-size --group-dirs=last'
alias lr='lsd -Ahl --total-size --tree --group-dirs=last'
alias ls='lsd -A --group-dirs=last'
alias mkdir='mkdir -p'
alias ps='procs --tree'
alias rm='trash -F'
alias time='gtime'
alias top='btm'
alias tree='lsd -A --tree --group-dirs=last'
alias vi='kak'
alias -g C='|tee >(pbcopy)'
alias -g G='|rg -S'
alias -g L='|bat --style=plain'
# チートシート表示
ch() { cheat $* | bat --style=plain -l sh }
# 直近のディレクトリをあいまい検索して移動
pop() { cd $(dirs -lp | bat -r 2: | fzf --no-sort --prompt='cd >') }
# Jsonファイルをgrep
jgrep() { gron | grep $* | gron -u }
# ディレクトリを作成＆移動
mkcd() {
    if [[ -d "$1" ]]; then
        cd "$1"
    else
        mkdir -p "$1" && cd "$1"
    fi
}

######################################################################
# cd
# cd記録数の設定
DIRSTACKSIZE=50
# cd検索パスの設定
cdpath=~/proj
# ディレクトリ名のみでもcd
setopt auto_cd
# cd時にpushをする
setopt auto_pushd
# pushに同じものを登録しない
setopt pushd_ignore_dups

# プロンプト表示時にディレクトリ内容をリストアップ
zle-line-init() {
    # TODO 色をつけたい（やり方不明）
    # TODO いい感じにwrapさせたい（ただの手抜き）
    local maxlen=$(echo $(( $COLUMNS * 2 )))
    local all=$(lsd -1FL --icon never --group-dirs first)
    local dirs=""
    for d (${(f)all}) {
        if [[ "$d" =~ "[ ]" ]]; then
            dirs="$dirs '$d'"
        else
            dirs="$dirs $d"
        fi
        if [ ${#dirs} -gt $maxlen ]; then
            dirs="${dirs:0:$maxlen-3}..."
            break
        fi
    }
    zle -M "$dirs"
}
zle -N zle-line-init

######################################################################
# history

# 履歴保存数の設定
HISTSIZE=10000
SAVEHIST=10000

# 履歴に時間も記録
setopt extended_history
# 履歴の同じ古いコマンドは削除
setopt hist_ignore_all_dups
# history (fc -l)コマンドを履歴に保存しない
setopt hist_no_store
# 履歴に余計な空白を記録しない
setopt hist_reduce_blanks
# 他ウィンドウと履歴を共有する
setopt share_history

# 最後のワードをスマートにする
# ls /usr/share
# ls !$&  or  ls ESC-.&
# ls !$  or ls ESC-. <-- insert-last-wordだと「&」が選ばれるが、smart-insert-last-wordでは「/usr/share」が選ばれる
autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word

# 履歴のあいまい検索
select-history() {
    LBUFFER=$(history -Dinr 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > " | choose 3:)
}
zle -N select-history
# 履歴をあいまい検索から実行
accept-history() {
    zle select-history
    zle accept-line
}
zle -N accept-history

######################################################################
# completion
# 補完を有効
autoload -Uz compinit && compinit

# 候補が大量時にもメニュー表示の確認せず表示させる
LISTMAX=-1

# カーソル位置での単語補完を有効
setopt complete_in_word
# リスト表示をコンパクトにする
setopt list_packed
# リスト選択を縦でなく横移動
setopt list_rows_first
# 自動でのmenu表示をしない
setopt no_auto_menu
# 自動でのmenu補完をしない
setopt no_menu_complete

# 補完メニューの色設定
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# 小文字入力でも大文字に補完一致させる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 項目毎に補完メニューをグループ化
zstyle ':completion:*' group-name ''
# 補完メニューのグループ名を色設定
zstyle ':completion:*:descriptions' format '%F{yellow}# %d:%f'
# 補完メニューのグループ表示順を設定
zstyle ':completion:*' group-order local-directories named-directories path-directories
# 空白時にもタブキーで補完させる
zstyle ':completion:*' insert-tab false

# 補完メニューの明示的表示
menu-complete-and-select() {
    zle menu-complete
    zle menu-select
}
zle -N menu-complete-and-select

######################################################################
# help
# cheatを起動させる（未入力時はmy-favorite決め打ち）
run-cheat() {
    if [ -z $BUFFER ]; then
        cheat my-favorite | bat --style=plain -l sh
    else
        if [ "$BUFFER" != "${BUFFER#\\}" ]; then
            # original command
            local cmd=$(echo ${BUFFER#\\} | choose 0)
        else
            # Possible alias
            local lbuf=$LBUFFER
            local rbuf=$RBUFFER
            BUFFER=$(echo $BUFFER | choose 0)
            zle _expand_alias
            local cmd=$(echo $BUFFER | choose 0)
            LBUFFER=$lbuf
            RBUFFER=$rbuf
        fi
        cheat $cmd | bat --style=plain -l sh
    fi
}
zle -N run-cheat

######################################################################
# 入力

# Tabはメニュー補完、option-iはbashっぽい補完（連番ファイル選択時に便利）
bindkey '^i' menu-complete-and-select # Tab
bindkey 'ˆ' expand-or-complete # option-i

# 履歴操作
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey '^r' accept-history
bindkey '®' select-history # TODO: menuselectの"^j"と"^m"みたいに確定キーで切り替えたい 

# Windows Like
# Terminal.appのプロファイル > キーボードで追加が必要
# Home(↖︎)→\033[H
# End(↘︎)→\033[F
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# optionをメタキーにせずそのままとし、特殊文字に必要なショートカットを割り当てる

# 単語単位
bindkey '∫' backward-word  # option-b
bindkey 'ƒ' forward-word # option-f
bindkey '∂' kill-word # option-d
bindkey '˙' backward-kill-word # option-h

# 最後の引数を再利用
bindkey '≥' insert-last-word # option-.

# 大文字、小文字
bindkey 'ç' capitalize-word # option-c
bindkey 'ü' up-case-word # option-u
bindkey '¬' down-case-word # option-d

# ヘルプ表示
bindkey '¿' run-cheat # option-? (option-shift-/)

# タブを入力したい時などに使う
bindkey 'œ' quoted-insert # option-q # Why does not control-q work?
bindkey -r "^v" # quoted-insert # Clipy shortcut

# menuselectキーマップ
zmodload -i zsh/complist
accept-line-anywhere() {
    zle accept-line
}
zle -N accept-line-anywhere
bindkey -M menuselect '^m' accept-line-anywhere # 通常は確定、"^j"でバッファ挿入のみ
bindkey -M menuselect '^[[Z' backward-char # shift-TABで戻る

# option-bなどでいい感じに単語移動
# less /usr/local/hoge <-- 通常は「最初の/」まで戻るが、これで「最後の/」に移動
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " &+,/:=@{|}"
zstyle ':zle:*' word-style unspecified

# ######################################################################
# Install app
# 他の設定を書き換えることがあるので、最後に記載する。
# 　select-word-styleがzsh-syntax-highlightingの後だと効かないのを確認済み。

# プロンプトカスタマイズ 
eval "$(starship init zsh)"

# cd 履歴からいい感じに移動
# bindkey j hoge OR 検索 ji
# https://news.mynavi.jp/techplus/article/techp5607/
# "^[[0n"クエリステータスレポート（返答）らしいけどなんだろう？
# bindkey "^[[0n" __zoxide_z_complete_helper
eval "$(zoxide init --cmd j zsh)"

# うっすら補完を表示
# → or End accept suggestion
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# コマンド入力中にシンタックスハイライト
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
