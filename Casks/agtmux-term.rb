cask "agtmux-term" do
  version "0.1.1"
  sha256 "4fe2780a3e1868992a42cde4713320faf06c30a8ef544b5b46bd02655e8e7de9"

  url "https://github.com/g960059/agtmux-term/releases/download/v#{version}/AgtmuxTerm-v#{version}.dmg"
  name "AgtmuxTerm"
  desc "macOS terminal cockpit for AI agent sessions powered by Ghostty"
  homepage "https://github.com/g960059/agtmux-term"

  depends_on macos: ">= :sonoma"

  app "AgtmuxTerm.app"

  # The agtmux daemon is bundled at Contents/Resources/Tools/agtmux.
  # Install the standalone CLI separately with: brew install agtmux

  zap trash: [
    "~/Library/Application Support/AGTMUXDesktop",
    "~/Library/Preferences/com.g960059.agtmux.term.plist",
    "~/Library/Caches/com.g960059.agtmux.term",
  ]
end
