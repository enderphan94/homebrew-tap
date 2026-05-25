cask "markview" do
  version "2.2.5"
  sha256 "bec3234735ce8b1925a7c7f976fe0f3f557f1815de8d029a163c36232a89f7da"

  url "https://github.com/enderphan94/markdown-app/releases/download/v#{version}/MarkView-#{version}.dmg"
  name "MarkView"
  desc "Offline markdown editor with mermaid diagrams and iCloud-syncable vault"
  homepage "https://github.com/enderphan94/markdown-app"

  # `livecheck` lets `brew livecheck markview` (and the auto-bumping
  # bots in homebrew/cask) detect new GitHub releases without us
  # touching the formula. We'll still update version + sha256 here on
  # every release via desktop/bump_cask.sh, but this lets curious
  # users / mirrors notice fresh versions on their own.
  livecheck do
    url :url
    strategy :github_latest
  end

  # MarkView ships its own in-app updater (queries GitHub Releases on
  # launch). Tell Homebrew not to fight us over what "managed update"
  # means — users see the update modal inside MarkView and can also
  # `brew upgrade --cask markview`. Either path works.
  auto_updates true
  depends_on macos: :big_sur

  app "MarkView.app"

  # Belt-and-braces: explicitly strip com.apple.quarantine after the
  # Cask copies the .app into /Applications. Modern Homebrew Cask
  # versions already do this for unsigned apps, but on some macOS
  # releases the bit-flags get rewritten rather than removed, which
  # CAN still trip the Gatekeeper warning the first time a user
  # double-clicks the app in Finder. Running xattr -dr ourselves
  # makes the install path identical to MarkView's in-app updater,
  # which has been bulletproof.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine",
                          "#{appdir}/MarkView.app"],
                   must_succeed: false
  end

  # `brew uninstall --cask markview` cleans the app. `brew uninstall
  # --zap --cask markview` ALSO removes per-Mac config + the vault
  # path pointer. The vault itself (~/Documents/MarkView Vault or
  # iCloud Drive/MarkView Vault) is NEVER zapped — the user's notes
  # live there and they likely want to keep them.
  zap trash: [
    "~/Library/Application Support/MarkView",
    "~/Library/Caches/com.kuberscan.markview",
    "~/Library/Preferences/com.kuberscan.markview.plist",
  ]
end
