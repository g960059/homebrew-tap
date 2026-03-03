class Agtmux < Formula
  desc "Real-time AI agent state monitor for tmux"
  homepage "https://github.com/g960059/agtmux"
  version "0.1.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.12/agtmux-aarch64-apple-darwin.tar.xz"
      sha256 "d94f25d7736795f4fe8dd31be0c16a433863464c985a2d77b4d7ca2c59f3cde4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.12/agtmux-x86_64-apple-darwin.tar.xz"
      sha256 "ece93910d195c807661af1e91fc35a26815707c387b0b7a1ac13bfc75eba9347"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.12/agtmux-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6cb7862364ff05e2ccdb65b0e4b14c9f012e8dad8c1e9bb47d07c96eb9b03350"
    end
    if Hardware::CPU.intel?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.12/agtmux-x86_64-unknown-linux-musl.tar.xz"
      sha256 "9a628d40b0a1079c2811f059783e41b7a35081c28e9cc84f74a5fce72eff10c0"
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
