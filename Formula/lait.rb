class Lait < Formula
  desc "A local-first, peer-to-peer, end-to-end-encrypted issue tracker built on iroh + Loro CRDTs"
  homepage "https://github.com/nixiesoftware/lait"
  version "0.7.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.2/lait-aarch64-apple-darwin.tar.gz"
      sha256 "85d2e45b509fe8e8643765eb81e707a0fac60e35237cec7b47446fa3e4eaab89"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.2/lait-x86_64-apple-darwin.tar.gz"
      sha256 "c2b4ffd283dfefb0f8a668ee17e5470a139d820a92ad1e398a5816cc5cc49ead"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.2/lait-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "21cd5b7b1e595433756be98dedbf4d4f32fa2fa0c2a425cbec052fd054719a89"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.2/lait-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "082eb881c75c41b9b8e0269b8bc21356809f7eb94c8b1c0531993a7cec0fd3b2"
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
