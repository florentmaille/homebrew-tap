cask "notch-usage" do
  version "0.4.1-preview"
  sha256 "9383413d72546509b26a9f54fa02e0dbdf87faf00f42effd544b880261e726d7"

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

    Sign out from the panel before uninstalling: it deletes the app's
    Keychain entries, which `brew uninstall --zap` cannot remove.
  EOS
end
