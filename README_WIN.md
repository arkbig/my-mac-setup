# Setup for Windows

基本はデフォルトのProgram Filesにインストールするが、それ以外がデフォルトの場合`C:\opt\`にインストールする。

## VS Code

VS Codeをインストールする。

## Git for Windows

Git for Windowsをインストールする。
`C:\opt\git` にインストールする。

### リポジトリクローン

このリポジトリをクローンする。
git-bash.exeを起動して、`./mkln.sh`を実行する。

`config/vscode/install-extensions.sh`を実行する。

## Git for Windows SDK

Git for Windows SDKをインストールする。
`C:\git-sdk-64` にインストールする。
`C:\git-sdk-64` を `C:\opt\git` にコピーする。（`.git`は除く。上書きしない。）

### zsh

```sh
pacman -Syuu
pacman -S zsh
```

## HackGen

HackGenフォントをインストールする。

## direnv

direnvをインストールする。
`C:\opt\bin`に配置して、PATHを通しておく。

## zsh-autosuggestions

`$HOME/github/zsh-autosuggestions`にcloneする。

## ツール類

```sh
pacman -S \
    mingw-w64-x86_64-bat \
    mingw-w64-x86_64-delta \
    mingw-w64-x86_64-dust \
    mingw-w64-x86_64-ripgrep \
    mingw-w64-x86_64-lsd \
    mingw-w64-x86_64-bottom \
    mingw-w64-x86_64-starship
```

duf,procs,zoxide をGitHubからインストールする。
GB <https://www.vector.co.jp/soft/win95/util/se327357.html> をインストールする。

## マウス設定

MX Master 3Sを使う場合、`Logi Option+`をインストールする。

![config/logioption/button.png]

![config/logioption/point.png]

## Clibor

クリップボード履歴アプリとして、Cliborを使う。
`config/clibor/Clibor.xml`をインストール先 `C:/opt/clibor/`にコピーする。

## AutoHotKey

AutoHotKey 2をインストールする。
`config/ahk/*.ahk`をスタートアップ（`shell:startup`）にショートカット作成。

- clibor.ahk ... Win+v でCliborを開く
- mouse.ahk ... 進むボタン+マウス移動 をスクロール変換する

## Beyond Compare 4

Beyond Compare 4をインストールする。
タスクトレイから`Options > Enable keyboard shortcut`を有効にする。

## Sysinternals Suite

Sysinternals Suiteをダウンロードする。

## Power Toys

Power Toysをインストール。
PowerToys Runの起動ショートカットを Win+Space に変更する。

## Windows Terminal

Windows Terminalをインストールする。
プロファイルでZshを追加する。
コマンドライン `C:\opt\git\bin\bash.exe -c zsh --login`

## Everyting

Everytingをインストールする。
オプションのキー割当で、検索ウィンドウ表示キーに`Alt+Space`を設定する。

## SSH鍵ペア作成

`ssh-keygen -t ed25519`
