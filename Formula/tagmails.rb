class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.18"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.18/tagmails-0.2.18-aarch64-apple-darwin.tar.gz"
    sha256 "17534784a2b8f27645d5ddc5b5156ddc175b8a7ba067b9d3405497f56a9cbfd4"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.18/tagmails-0.2.18-x86_64-apple-darwin.tar.gz"
    sha256 "dc079564ab2c37c2c3da2ed5c9c3b74c8881035b7b9c34ad7b8bc909a810e558"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.18/tagmails-0.2.18-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "5fe325d57774d03468b600e5df82b73616df203ee29bfbb307cc76e276e144c0"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.18/tagmails-0.2.18-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ca3ee7f44046190f25d15219031d7578c991421684235776309de32a02c48a77"
    end
  end

  depends_on "node"

  def install
    bin.install "bin/tagmails"
    adapters = libexec/"tagmails"
    adapters.install Dir["libexec/tagmails/*"]
    cd adapters do
      system "npm", "ci", "--omit=dev", "--ignore-scripts", "--no-audit", "--no-fund"
    end
  end

  def caveats
    <<~EOS
      Create a pairing code at https://tagmails.com/setup, then run:
        tagmails pair <code>
        tagmails start
      After upgrading, run `tagmails start` again to restart the background service.
    EOS
  end

  test do
    assert_match "tagmails #{version}", shell_output("#{bin}/tagmails --version")
    assert_match "Usage:", shell_output("#{bin}/tagmails --help")
  end
end
