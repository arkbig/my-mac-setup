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

1. Karabiner
   1. Devices > 全チェック
2. システム環境設定 > マウス
   1. スクロールの方向：ナチュラル`チェックはずす`
   2. 軌跡の速さ`Max`
3. システム環境設定 > キーボード
   1. キーのリピート`Mac`
   2. リピート入力認識までの時間`最短`
   3. ショートカット
      1. Launchpad Dockを自動的に表示/非表示のオン/オフ `チェックはずす`
      2. ディスプレイの明度を下げる & 上げる　`チェックはずす`
      3. Mission Control > アプリケーションのウィンドウ `^↓`だけ残し`チェックはずす`
      4. キーボード
         1. 次のウィンドウを操作対象にする `command + option + tab`
         2. 他は`チェックはずす`
      5. 入力ソース　`チェックはずす`
      6. スクリーンショット　`チェックはずす`
         1. スクリーンショットと収録のオプション `F13`(PrintScreen)
      7. サービス　`チェックはずす`
      8. Spotlight `Control + SP`
         1. 他は　`チェックはずす`
      9. アクセシビリティ　`チェックはずす`
      10. アプリケーション　`チェックはずす`
   4. 入力ソース
      1. 日本語
          1. 入力モード: "英字"チェック
          2. "¥"キーで入力する文字"\"
      2. ABC 削除
4. システム環境 > Dockとメニューバー
   1. Dockを自動的に表示/非表示　`チェック`j
   2. 時計　24時間表にする
   3. Spotlight メニューバーに表示　`チェックはずす`
   4. Siri メニューバーに表示　`チェックはずす`

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
