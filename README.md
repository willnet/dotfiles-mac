# dotfiles-mac

macOS settings and configuration files for Apple Silicon Macs, managed with
[mise bootstrap](https://mise.jdx.dev/bootstrap.html).

## Bootstrap

Install [mise](https://mise.jdx.dev/getting-started.html) 2026.10.10 or later,
then run the following from this repository:

```sh
mise trust
```

Preview and apply the shared setup:

```sh
mise bootstrap --dry-run
mise bootstrap
```

Open a new login shell after applying the configuration.

`mise.toml` declares the shared setup:

- `[bootstrap.packages]` installs `ghq`, `peco`, `git`, `gh`, `ag`, `starship`,
  RubyMine, VS Code, and the Moralerspace font through mise's
  built-in `brew` and `brew-cask` managers. Homebrew itself is not required;
  mise is installed separately.
- `[dotfiles]` copies Git and zsh configuration files and links Claude Code,
  Codex, and GitHub Copilot instructions to the shared source in this repository.
- Line entries load the zsh configuration without replacing other startup-file
  contents or adding duplicate source lines.
- `[bootstrap.mise_shell_activate]` configures mise shims in `~/.zprofile` and
  interactive activation in `~/.zshrc`. The zsh tools file initializes Starship.
- `[bootstrap.macos.dock]` automatically hides the Dock.

The peco widgets bind `Ctrl-R` to history search and `Ctrl-]` to repository
selection. Keep this checkout in place because the instruction symlinks refer
to its files.

## Update and inspect

After editing the configuration, run `mise bootstrap` again. Resources that
already match are skipped. To inspect the current state:

```sh
mise bootstrap status
mise dotfiles diff
```

Apply only packages or dotfiles (including shell activation):

```sh
mise bootstrap --only packages
mise bootstrap --only dotfiles,mise-shell-activate
```

Apply one managed file:

```sh
mise dotfiles apply ~/.config/git/ignore
```

Apply only macOS preferences, then restart the Dock to reflect the change:

```sh
mise bootstrap --only macos-defaults
killall Dock
```

## Migration

`bin/dotfiles` and `Brewfile` have been replaced by `mise.toml`. Existing source
lines in `~/.zshrc` and `~/.zprofile` are reused. The updated `tools.zsh` removes
its previous mise activation, which is now managed by bootstrap.

If existing managed files differ, review `mise dotfiles diff` first. To replace
them with the repository versions, run:

```sh
mise bootstrap --force-dotfiles
```
