# dotfiles-mac

macOS settings and configuration files for Apple Silicon Macs, managed with
[mise bootstrap](https://mise.jdx.dev/bootstrap.html).

## Bootstrap

Install [mise](https://mise.jdx.dev/getting-started.html) 2026.10.10 or later,
then run the following from this repository:

```sh
mise trust
```

Choose an environment as described below, then preview and apply it:

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

## Personal and work Macs

Following [this setup pattern](https://blog.shibayu36.org/entry/2026/10/13/173000),
environment files are layered on top of the shared `mise.toml`:

| File | Applies to | Contents |
| --- | --- | --- |
| `mise.toml` | Both | Shared packages, dotfiles, and Dock configuration |
| `mise.personal.toml` | Personal | 1Password and Google Chrome |
| `mise.work.toml` | Work | Work-only additions and overrides (currently empty) |

On each Mac, create `.miserc.local.toml` in this repository with your selection:

```toml
env = ["personal"]
```

Use `env = ["work"]` on a work Mac. This file is ignored by Git, so the choice
stays on that Mac. After selecting it, run `mise trust` to trust the environment
file, then use `mise bootstrap` as usual. Check loaded files with `mise config`.

For a machine-wide selection, you can instead set the same `env` in
`~/.config/mise/miserc.local.toml`, as in the article. It affects other mise
projects too. A one-time selection is also possible:

```sh
mise -E personal bootstrap --dry-run
mise -E personal bootstrap
mise -E work bootstrap --dry-run
```

Add environment-specific `[bootstrap.packages]`, `[dotfiles]`, or macOS settings
to the corresponding file. A dotfile with the same target overrides the shared
source. Keep private overrides in `mise.personal.local.toml` or
`mise.work.local.toml`, both ignored by Git.

Existing settings, including the Git identity in `config/git/config`, remain
shared. Changing environments does not uninstall packages installed previously.

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
