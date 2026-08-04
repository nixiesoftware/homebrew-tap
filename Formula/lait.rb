class Lait < Formula
  desc "A local-first, peer-to-peer, end-to-end-encrypted issue tracker built on iroh + Loro CRDTs"
  homepage "https://github.com/nixiesoftware/lait"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.0/lait-aarch64-apple-darwin.tar.gz"
      sha256 "3d652a92e580dff3fc9f3c31132a39adfcfd0b8048b63afb4eb2fd120f34a465"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.0/lait-x86_64-apple-darwin.tar.gz"
      sha256 "82b270c45dd268c94147adc6d136d55252ad22c86bb482fc2320193d2cc96e52"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.0/lait-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2b412572fa4593266a5fe4d59b944cb21d071c993b9326589fbfbf7c6053915b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nixiesoftware/lait/releases/download/v0.7.0/lait-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "23540753966eecebfe43fb6edb0a70350e870b61b4700cc7867a6d0a38551d50"
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
