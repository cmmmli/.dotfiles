# .dotfiles

macOS 用の dotfiles リポジトリ。

## 構成

```
.dotfiles/
├── .config/
│   ├── aerospace/      # AeroSpace (タイル型ウィンドウマネージャ)
│   ├── alacritty/      # Alacritty (ターミナル)
│   ├── aqua.yaml       # aqua (CLIツール管理)
│   ├── ghostty/        # Ghostty (ターミナル)
│   ├── sheldon/        # Sheldon (zsh プラグインマネージャ)
│   ├── starship.toml   # Starship (プロンプト)
│   └── zellij/         # Zellij (ターミナルマルチプレクサ)
├── git/                # Git 設定
├── karabiner/          # Karabiner-Elements (キーリマップ)
├── vim/                # Vim 設定
├── zsh/                # zsh 設定
│   ├── my_zshrc.sh           # メイン設定
│   ├── zshrc_useful.sh       # ユーティリティ設定
│   └── generate-completions.sh  # 補完キャッシュ生成
└── .Brewfile           # Homebrew パッケージリスト
```

## セットアップ

```bash
# リポジトリをクローン
git clone https://github.com/cmmmli/.dotfiles.git ~/.dotfiles

# シンボリックリンクを作成
ln -sf ~/.dotfiles/zsh/my_zshrc.sh ~/.zshrc
ln -sf ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git/.gitignore_global ~/.gitignore_global

# .config 配下は適宜リンク
ln -sf ~/.dotfiles/.config/starship.toml ~/.config/starship.toml
ln -sf ~/.dotfiles/.config/sheldon ~/.config/sheldon
# ... 他の設定も同様
```

## zsh 設定

### プラグイン管理

[Sheldon](https://github.com/rossmacarthur/sheldon) を使用。

```bash
# プラグインの更新
sheldon lock --update
```

### 補完キャッシュ

kubectl, gh, skaffold, op (1Password CLI) の補完は起動高速化のためキャッシュ化しています。

```bash
# CLIツールを更新した後に実行
~/.dotfiles/zsh/generate-completions.sh

# キャッシュを再生成して反映
rm -f ~/.zcompdump && exec zsh
```

### バージョン管理ツール

| ツール | 用途 |
|--------|------|
| [Volta](https://volta.sh/) | Node.js, Yarn |
| [pyenv](https://github.com/pyenv/pyenv) | Python |
| [rbenv](https://github.com/rbenv/rbenv) | Ruby |
| [mise](https://mise.jdx.dev/) | 複数言語 |
| [aqua](https://aquaproj.github.io/) | CLIツール |

rbenv と pyenv は遅延初期化により、初回使用時までロードを遅延しています。

## 主要なツール

- **ターミナル**: Ghostty / Alacritty
- **プロンプト**: Starship
- **ウィンドウマネージャ**: AeroSpace
- **キーリマップ**: Karabiner-Elements
- **コンテナ**: Rancher Desktop (Docker)

## メンテナンス

### Homebrew パッケージの更新

```bash
brew bundle dump --file=~/.dotfiles/.Brewfile --force
```

### シェル起動時間の確認

```bash
for i in {1..5}; do time zsh -i -c exit; done
```
