cask "notch-usage" do
  version "0.2.1-preview"
  sha256 "369e8fe14d2386a8670432cbebb0a2bd4bcb649f98d30d9e4a68c4efc42c8568"

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
  EOS
end
