class AgtmuxRuntime < Formula
  desc "Real-time AI agent state monitor for tmux"
  homepage "https://github.com/g960059/agtmux"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.0/agtmux-runtime-aarch64-apple-darwin.tar.xz"
      sha256 "a8d772a0397b46c1679088b84f9f6ea2d35a2e9e3daafeab9f671ef3a15f2408"
    end
    if Hardware::CPU.intel?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.0/agtmux-runtime-x86_64-apple-darwin.tar.xz"
      sha256 "187275983dea6bcd203fd34414d779050cec892ac4f373c321efda57187a7565"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.0/agtmux-runtime-aarch64-unknown-linux-musl.tar.xz"
      sha256 "77b733a9a9c286c5fc0810f858f05931510d24e910c69c606c452bfc7df2adde"
    end
    if Hardware::CPU.intel?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.0/agtmux-runtime-x86_64-unknown-linux-musl.tar.xz"
      sha256 "d927adaa2d92471c9360aa635941724dd6301a4abb699e40b6da5b44c07d4a57"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "agtmux" if OS.mac? && Hardware::CPU.arm?
    bin.install "agtmux" if OS.mac? && Hardware::CPU.intel?
    bin.install "agtmux" if OS.linux? && Hardware::CPU.arm?
    bin.install "agtmux" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
