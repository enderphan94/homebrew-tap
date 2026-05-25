# enderphan94/homebrew-tap

Homebrew tap for [MarkView](https://github.com/enderphan94/markdown-app),
the offline macOS markdown editor with mermaid diagrams and an
iCloud-syncable vault.

## Install MarkView

```bash
brew install --cask enderphan94/tap/markview
```

Homebrew handles everything Gatekeeper would normally complain about:
downloads the latest `.dmg`, mounts it, copies `MarkView.app` to
`/Applications`, strips the `com.apple.quarantine` attribute, and
ejects. Result: **MarkView launches with no "developer cannot be
verified" warning** the first time, no right-click → Open dance.

## Update

```bash
brew upgrade --cask markview
```

MarkView also self-updates from GitHub Releases on launch — either
path works.

## Uninstall

```bash
brew uninstall --cask markview
```

This leaves your vault untouched (your notes are real `.md` files in
whatever folder you picked during MarkView's first-launch setup). To
also remove MarkView's per-Mac config + caches:

```bash
brew uninstall --zap --cask markview
```

The vault folder itself is never touched.

## Source code

The MarkView app's source lives at
[enderphan94/markdown](https://github.com/enderphan94/markdown).
The `.dmg` releases live at
[enderphan94/markdown-app](https://github.com/enderphan94/markdown-app).
