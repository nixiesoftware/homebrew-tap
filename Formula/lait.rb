class Lait < Formula
  desc "A local-first, peer-to-peer, end-to-end-encrypted issue tracker built on iroh + Loro CRDTs"
  homepage "https://github.com/nixiesoftware/lait"
  version "0.7.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.4/lait-aarch64-apple-darwin.tar.gz"
      sha256 "a49b80a04a4fb9fb720e773e6bc02691ff4b60388530204610c1e074e2f06127"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.4/lait-x86_64-apple-darwin.tar.gz"
      sha256 "1b7d3154ad451e755eb0a7f5acdfe2086d07d40a64c2fb703ae2a93afcbe8c01"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.4/lait-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "66d699cab84137ff6ee65243beb3479a6dacb2857f0335e7015e9cf6624195a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.4/lait-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7559b225546d9addad3f6cd19876785b5e8597caea65b3796f31e684e5ec3410"
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
