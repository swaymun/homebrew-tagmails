class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.10"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.10/tagmails-0.2.10-aarch64-apple-darwin.tar.gz"
    sha256 "7b75c95f7b10f703130276308addaca652bf11d32d97ff54ac59ed3e2a6d3426"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.10/tagmails-0.2.10-x86_64-apple-darwin.tar.gz"
    sha256 "5951423fbbf1fbb267e1e53080cd7bf1e87c43ac4049f5cd4ac985fac7c0b844"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.10/tagmails-0.2.10-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "ad1618e042c363c9ce3249dcc80d4ae2111a6b84fe5f166005c4201afc7d57ba"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.10/tagmails-0.2.10-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "afa2501ec1371e0679546b75cc426a059855a0ddef035648d55f4e3b2ac11ffa"
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
