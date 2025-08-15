# Setup

This guide outlines the steps to set up these dotfiles.

## 1. Prerequisites & Initial Git Setup

First, ensure `curl` and `git` are installed.

Then, clone this dotfiles repository and configure Git with your personal details.

```bash
# Clone the repository
git clone https://github.com/Vl4dk0/dotfiles.git ~/dotfiles

# Configure Git
git config --global user.name "Vladko Jancar"
git config --global user.email "jvladko@gmail.com"
```

## 2. Install Homebrew

Homebrew is used to install and manage most of the required packages.

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to your PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

## 3. Install Core Packages via Homebrew

Install stuff using Homebrew.

```bash
brew install neovim fnm tmux stow zsh tldr gemini-cli direnv fzf starship gh lazygit tree ripgrep fd
```

Setup git

```bash
gh extension install github/gh-copilot
gh auth login
gh auth setup-git
```

## 4. Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## 5. Set Up Node.js using fnm

Use FNM to install and set the latest Long-Term Support (LTS) version of Node.js.

```bash
fnm install --lts
fnm use --lts
```

## 6. Install Rust from rustup

Install Rust using the official `rustup` installer.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
Follow the on-screen instructions to complete the installation.

## 7. Stow Dotfiles

Use `stow` to create symlinks from the files in this repository to your home directory. This effectively "installs" your configurations.

```bash
cd ~/dotfiles
stow .
```
If there is error with files already existing, just delete those files and only keep those inside dotfiles, then try stowing again.

## 8. Set Up Zsh & Oh My Zsh

Now that your `.zshrc` is in place, install Oh My Zsh and set Zsh as your default shell.

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Change the default shell to Zsh
chsh -s $(which zsh)
```
**Important:** You must **log out and log back in** for the shell change to take full effect.

## 9. Finalize Neovim Setup

The last step is to let `lazy.nvim` install all your Neovim plugins.

Simply launch Neovim:
```bash
nvim
```
On the first launch, `lazy.nvim` will automatically download and set up all the plugins defined in your configuration.

If you get error with debugpy:
```
mkdir ~/.virtualenvs
cd ~/.virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

TODO: add docker instalation steps and setup.
