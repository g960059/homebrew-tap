class Agtmux < Formula
  desc "Real-time AI agent state monitor for tmux"
  homepage "https://github.com/g960059/agtmux"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.9/agtmux-aarch64-apple-darwin.tar.xz"
      sha256 "d6011f44178d04ac48026a935a8223771e48fd9910efd3d74cf3d4d736b282c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.9/agtmux-x86_64-apple-darwin.tar.xz"
      sha256 "14caac40ce0328a716894380cf57108a023609c98672b51fa75f983bea6de4c0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.9/agtmux-aarch64-unknown-linux-musl.tar.xz"
      sha256 "30d2585cceb85fb0a518d097fa39299fd64ef42c7f25bbd40add01f8225d9005"
    end
    if Hardware::CPU.intel?
      url "https://github.com/g960059/agtmux/releases/download/v0.1.9/agtmux-x86_64-unknown-linux-musl.tar.xz"
      sha256 "2bad0159e3970ce7373668831a68c2bf2f59633b4bc9e98e1ba4a0c95488fe49"
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
