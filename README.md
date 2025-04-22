# andy4747's Dotfiles 🛠️

Welcome to my personal dotfiles repo! This is where I keep configuration files for my development environment, including Neovim, Tmux, Kitty, and Zsh. These dotfiles are setup just for my needs.

## ✨ Features

- **Neovim**: Modular Lua configuration with LSP, Treesitter, Telescope, Neo-Tree and Tmux navigation support.
- **Tmux**: Minimalist statusline, vim-like keybindings, and custom window switching.
- **Kitty Terminal**: my config for kitty terminal.
- **Zsh**: my ~/.zshrc file with all my configs.

## 🗂 Structure

```
.
├── .config
│   ├── kitty
│   │   └── kitty.conf
│   └── nvim
│       ├── init.lua
│       ├── lua
│       │   └── andy4747
│       │       ├── core
│       │       │   ├── autocmds.lua
│       │       │   ├── keymaps.lua
│       │       │   └── options.lua
│       │       └── plugins
│       │           ├── editor.lua
│       │           ├── init.lua
│       │           ├── lsp.lua
│       │           ├── tools.lua
│       │           └── ui.lua
│       └── README.md
├── .gitconfig
├── README.md
├── scripts
│   ├── install_go_tools.sh
│   └── setup_github_ssh_linux.sh
└── .tmux.conf
```

## 🚀 Quick Setup

Clone the repository:

```bash
git clone https://github.com/andy4747/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Then manually symlink the files or run an install script if included:

```bash
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/kitty ~/.config/kitty
```

> Back up any existing configs before linking.

<!-- ## 📸 Screenshots

_(Optional: Add screenshots of your terminal, Neovim in action, etc.)_ -->

## 🔧 Dependencies

Mandatory Dependencies:

- Neovim 0.10+
- Tmux 3.2+
- Kitty terminal
- Zsh + a plugin manager (e.g. [zinit](https://github.com/zdharma-continuum/zinit), [oh-my-zsh](https://ohmyz.sh/))
- Fonts (FiraCode Nerd Font)

## 🙌 Credits

- Inspired by [ThePrimeagen](https://github.com/ThePrimeagen), [tjdevries](https://github.com/tjdevries), [
Seth Phaeno](https://www.youtube.com/@sethyedw), [Josean Martinez](https://www.youtube.com/@joseanmartinez), [Dreams of Code](https://www.youtube.com/@dreamsofcode) and the dotfiles community.
- Uses various open-source plugins and themes — check individual config folders for details.

<!-- ## 📝 License

MIT — feel free to fork and adapt. -->

---

Made with ❤️ by [andy4747](https://github.com/andy4747)
