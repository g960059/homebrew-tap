cask "agtmux-term" do
  version "0.1.0"
  sha256 "c3fef081e9bcd04c486db842fcebdf2cc2cd94734ba596b2cc6d4bc6ceb3d07b"

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
