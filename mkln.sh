#!/usr/bin/env bash
set -eu
# set -x

if [ "$(uname)" = "Darwin" ]; then
    os=MacOS
elif [[ "$(uname)" =~ "_NT-" ]]; then
    os=Windows
elif [[ "$(uname -r)" =~ "-WSL2$" ]]; then
    os=WSL
else
    os=Linux
fi

# シンボリックリンクが作れるか確認
can_mkln() {
    local org_file
    local lnk_file
    org_file=$(mktemp)
    lnk_file=$(mktemp)
    # オリジナルファイル作成
    echo "before" >"$org_file"
    if [ ! -e "$org_file" ]; then
        echo "Can't create temporary file: $org_file"
        rm -f "$org_file" "$lnk_file"
        return 1
    fi
    # シンボリックリンク作成
    if [ -e "$lnk_file" ]; then
        rm -f "$lnk_file"
    fi
    ln -s "$org_file" "$lnk_file"
    if [ ! -L "$lnk_file" ]; then
        echo "Can't create symbolic link: $lnk_file"
        rm -f "$org_file" "$lnk_file"
        return 1
    fi
    # オリジナルファイルを更新して、シンボリックリンクが更新されるか確認
    echo "after" >>"$org_file"
    if [ "$(cat "$lnk_file")" != "$(cat "$org_file")" ]; then
        echo "Can't update symbolic link: $lnk_file"
        rm -f "$org_file" "$lnk_file"
        return 1
    fi
    # 後始末
    rm -f "$org_file" "$lnk_file"
    return 0
}

if ! can_mkln; then
    if [ "$os" = "Windows" ]; then
        # Windows MSYS2の場合は、いくつか設定が必要
        echo "1) 'export MSYS=winsymlinks:nativestrict' が設定されていますか？"
        echo "    '/etc/profile' の最初に設定します。"
        echo "    例)"
        echo "        export MSYS=winsymlinks:nativestrict"
        echo "        export MSYS_PATH_TYPE=inherit"
        echo "        export HOME=/c/Users/$(whoami)"
        echo "        export TZ=Asia/Tokyo"
        echo "        export LANG=C.UTF-8"
        echo "        export C_INCLUDE_PATH=\"C:/git/usr/local/include\""
        echo "        export CPLUS_INCLUDE_PATH=\"C:/git/usr/local/include\""
        echo "        export LD_LIBRARY_PATH=\"C:/git/usr/local/lib\""
        echo "    ついでに、/etc/profile.d/以下のスクリプトを.bashにリネームして、/etc/profileでbash時に読み込むよう'profile_d bash'を追加しておくとよいです。"
        echo "    - 000-msys2.sh"
        echo "    - env.sh"
        echo "    - 上記以外のスクリプトを.shから.bashにリネーム"
        echo "2) グループポリシーで 'Enable symbolic links' が有効になっていますか？"
        echo "    'ローカルコンピュータポリシー > コンピューターの構成 > Windowsの設定 > セキュリティ設定 > ローカルポリシー > ユーザー権利の割り当て / シンボリックリンクの作成' にユーザーを追加して、サインアウトしてください。"
    fi
    exit 1
fi

mkln() {
    if [ -e "$2" ]; then
        mv "$2" "$2.bak"
    elif [ ! -d "$(dirname "$2")" ]; then
        mkdir -p "$(dirname "$2")"
    fi
    ln -s "$1" "$2"
}

BASEDIR=$(cd "$(dirname "$0")" && pwd)
mkln "$BASEDIR/config" ~/.config

mkln ~/.config/zsh/.zshrc ~/.zshrc
mkln ~/.config/zsh/.zprofile ~/.zprofile

mkln ~/.config/git/.gitconfig ~/.gitconfig

if [ "$os" = "MacOS" ]; then
    mkln ~/.config/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
elif [ "$os" = "Windows" ]; then
    mkln ~/.config/vscode/settings.json ~/AppData/Roaming/Code/User/settings.json
    mkln ~/.config/vscode/keybindings.json ~/AppData/Roaming/Code/User/keybindings.json
else
    mkln ~/.config/vscode/settings.json ~/.vscode/settings.json
    mkln ~/.config/vscode/keybindings.json ~/.vscode/keybindings.json
fi
