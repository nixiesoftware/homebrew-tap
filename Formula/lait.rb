class Lait < Formula
  desc "A local-first, peer-to-peer, end-to-end-encrypted issue tracker built on iroh + Loro CRDTs"
  homepage "https://github.com/nixiesoftware/lait"
  version "0.7.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.5/lait-aarch64-apple-darwin.tar.gz"
      sha256 "3c080b073bfe5d3ebec632ce30d5aec784458bba9764435bb29c1e74e1f61568"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.5/lait-x86_64-apple-darwin.tar.gz"
      sha256 "3242cfd0fdced863c8ec146fe473abba0511ea7491d04ceef273457210bef455"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.5/lait-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e5cefd72a5e54b68ccd4dcf4142b033e57e8eee9bfef840723e4e5ab2d837446"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.5/lait-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aaa491ba68248b565c01375683ea6388be501acf0fdda0c35e489ec95b41cb6d"
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
