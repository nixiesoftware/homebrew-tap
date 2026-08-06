class Lait < Formula
  desc "A local-first, peer-to-peer, end-to-end-encrypted issue tracker built on iroh + Loro CRDTs"
  homepage "https://github.com/nixiesoftware/lait"
  version "0.7.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.10/lait-aarch64-apple-darwin.tar.gz"
      sha256 "831aeede47d274e30fafea9f8726b273b44e616f4c7cfa8f5bca9d431c8ab3ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.10/lait-x86_64-apple-darwin.tar.gz"
      sha256 "0fd8d9891176ce03ffddf6477d3a76e2b89d07772521544dec3ddfefac72ea23"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.10/lait-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "57db488f8b15d32345091f828ad35d05236dbfe09f152a54e45669ecf044a1ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.10/lait-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "de3a095397a1d2cbcafbb9db813bc05fc6fe9e1928e2d0f27a4fa5873daa1ecb"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "lait"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lait"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lait"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lait"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
