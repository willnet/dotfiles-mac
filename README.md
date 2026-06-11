# dotfiles-mac

macOS settings and configuration files.

## Install

Install Homebrew and the development tools declared in `Brewfile`:

```sh
bin/dotfiles install
```

This installs `ghq`, `peco`, `git`, `gh`, `ag`, `starship`, and the Moralerspace
font. Homebrew's environment is applied only while the command is running;
shell startup files are not modified.

## Import

Import all managed config files:

```sh
bin/dotfiles import
```

Import only the global Git ignore file:

```sh
bin/dotfiles import git-ignore
```
