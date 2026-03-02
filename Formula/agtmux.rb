class Agtmux < Formula
  desc "Real-time AI agent state monitor for tmux"
  homepage "https://github.com/g960059/agtmux"
  version "0.1.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.11/agtmux-aarch64-apple-darwin.tar.xz"
      sha256 "bf303429b8d7facf5d8c0c44dfd1d25e2dc709d6b10580db6438105583951f74"
    end
    if Hardware::CPU.intel?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.11/agtmux-x86_64-apple-darwin.tar.xz"
      sha256 "5dd39fbfc35ed68151719925f90c3ed115c66935c4864e2502f61d5e46783f27"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.11/agtmux-aarch64-unknown-linux-musl.tar.xz"
      sha256 "0a881e0dcaa65eb9155d602d7ca2efe2be2a2ccae10427e9bdbbf1c7f19aeeaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.11/agtmux-x86_64-unknown-linux-musl.tar.xz"
      sha256 "e8d80fc5e7f695ad9bd02262e468e6c563f8aec117edddf0320f2fc248e48166"
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
