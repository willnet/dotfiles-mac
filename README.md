# dotfiles-mac

macOS settings and configuration files.

## Install

Install Homebrew and the development tools declared in `Brewfile`:

```sh
bin/dotfiles install
```

This installs `ghq`, `peco`, `git`, `gh`, `ag`, `starship`, `mise`, and the
Moralerspace font.

## Import

Import all managed config files:

```sh
bin/dotfiles import
```

Import only the global Git ignore file:

```sh
bin/dotfiles import git-ignore
```

Import zsh aliases and load them from `~/.zshrc`:

```sh
bin/dotfiles import zsh-aliases
```

Import peco history and ghq widgets and load them from `~/.zshrc`:

```sh
bin/dotfiles import zsh-peco
```

The widgets bind `Ctrl-R` to history search and `Ctrl-]` to repository selection.

Configure Homebrew in `~/.zprofile`, then activate mise and Starship from `~/.zshrc`:

```sh
bin/dotfiles import zsh-tools
```

The `all` target includes this setup, so a new Mac can be configured with:

```sh
bin/dotfiles install
bin/dotfiles import
```
