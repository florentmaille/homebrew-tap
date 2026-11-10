cask "notch-usage" do
  version "0.6.3-preview"
  sha256 "7a53efc844e2c6b5042ce1d7a13e3cde3437b33475d4b8a840857354471c5a61"

  url "https://github.com/florentmaille/Notch-Usage/releases/download/v#{version}/NotchUsage-#{version}.zip"
  name "Notch Usage"
  desc "Claude usage limits in the MacBook notch"
  homepage "https://github.com/florentmaille/Notch-Usage"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+(?:-preview)?)$/i)
    strategy :github_releases
  end

  depends_on macos: :sonoma

  app "NotchUsage.app"

  uninstall quit: "com.notchusage.app"

  zap trash: [
    "~/Library/Application Support/NotchUsage",
    "~/Library/Caches/com.notchusage.app",
    "~/Library/HTTPStorages/com.notchusage.app",
    "~/Library/HTTPStorages/com.notchusage.app.binarycookies",
    "~/Library/Preferences/com.notchusage.app.plist",
    "~/Library/WebKit/com.notchusage.app",
  ]

  caveats <<~EOS
    Notch Usage is not notarized yet. On first launch macOS blocks it: open
    System Settings → Privacy & Security and click "Open Anyway".

    Before uninstalling, in the panel: turn off "Follow Claude Code" (it
    removes the app's hook entries from ~/.claude/settings.json; left behind,
    they do nothing) and sign out (it deletes the app's Keychain entries,
    which `brew uninstall --zap` cannot remove).
  EOS
end
