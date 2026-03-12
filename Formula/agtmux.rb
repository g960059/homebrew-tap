class Agtmux < Formula
  desc "Real-time AI agent state monitor for tmux"
  homepage "https://github.com/g960059/agtmux"
  version "0.1.19"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.19/agtmux-aarch64-apple-darwin.tar.xz"
      sha256 "0c4bfffb2e7247e6f96fee31e37e46bfc20288ee184b086558a82fc203258c5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.19/agtmux-x86_64-apple-darwin.tar.xz"
      sha256 "ce55a32dabb1906090c715b662363af3706561e178903b15dfdf8a957a6cd55e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.19/agtmux-aarch64-unknown-linux-musl.tar.xz"
      sha256 "fe99f0a304aa32469ba9b30ddd93834e578f69a3187d28ad84f1ab55634395ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.19/agtmux-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ae9d1e1f1d33624c5ca97be2ec5d978a25a2405648eeb0fa5eed68d5a9b5aa7b"
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
