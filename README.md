# Setup for Mac OS

## 設定の同期

1. キーボードのJIS配列を使用
   1. 標準設定で「_」（アンダースコア）が打てればOK
   2. ダメならKarabinerインストール
      1. Virtual keyboardタブ
      2. Country code:`45`
2. Apple IDでサインイン
3. `git clone https://github.com/arkbig/my-mac-setup.git proj/my-mac-setup`
   1. 初回はコマンドラインツールのインストールが始まる
4. `proj/my-mac-setup/mkln.sh`

## 手動設定

1. システム環境設定 > マウス
   1. スクロールの方向：ナチュラル`チェックはずす`
   2. 軌跡の速さ`Max`
2. システム環境設定 > キーボード
   1. キーのリピート`Mac`
   2. リピート入力認識までの時間`最短`
   3. ショートカット
      1. Launchpad > Launchpadを表示を無効
      2. キーボード > 次のウィンドウを操作対象にする `command + option + tab`
3. Karabiner
   1. Devices > 全チェック
4. システム環境設定 > キーボード > ショートカット
   1. Launchpadを表示 `Control + R`
   2. Mission Control デスクトップ表示 `Control + D`
   3. 入力ソース　`チェックはずす`
   4. Spotlight `Control + SP`
5. Homebrew
   1. Install from site command
   2. `eval "$(/opt/homebrew/bin/brew shellenv)"`
   3. `brew bundle --file ~/.config/homnebrew/Brewfile`
6. Docker
   1. システム環境設定 > ユーザーとグループ > ログイン項目 `ターミナル`を追加
   2. `git clone https://github.com/arkbig/devbase.git proj/devbase`
   3. [compose Releases](https://github.com/docker/compose/releases)
      1. `mkdir -p ~/.docker/cli-plugins; mv Downloads/docker-compose-darwin-aarch64 ~/.docker/cli-plugins/docker-compose; chmod +x ~/.docker/cli-plugins/docker-compose`
      2. `docker compose help`してシステム環境設定 > セキュリティとプライバシー > 一般 > docker-composeをこのまま許可
      3. `ln -s ~/.config/docker .colima/docker`
      4. [devbase使用方法](https://zenn.dev/arkbig/books/devbase-2022_b1b24e6e8db350a1f7f379af3833e90d79ad5/viewer/conclusion)
7. Terminal
   1. プロファイルを読み込む `~/.config/terminal/Big.terminal`
8. OneDrive
   1. Install from site download

9. Chrome
    1. Install from site download

10. VS Code
    1. Install from site download
    2. `shell command: install`
    3. `~/.config/vscode/install-extensions.sh`
    4. delete shortcut `command + option + tab`

## バックアップ

```sh
~/.config/backup.sh
(cd proj/my-mac-setup && git add . && git commit)
```

## TODO

fzfを使ったhistory検索がいまいちなら、mcfly(historyをSQLiteに保存してディレクトリとか見てランキング検索)を使ってみる。
