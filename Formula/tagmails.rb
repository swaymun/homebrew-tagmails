class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.12"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.12/tagmails-0.2.12-aarch64-apple-darwin.tar.gz"
    sha256 "16bc82862928a6728a69c444d5350a7487bb74efa400f23b59de522a5c7eea26"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.12/tagmails-0.2.12-x86_64-apple-darwin.tar.gz"
    sha256 "d5b2c5b496075ead5bf25010db5a975f2d753e89c2d8ff3d1c10b7a34163ae2f"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.12/tagmails-0.2.12-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "92d7021c7d36ef8059c91dc2181dc5796f024a2c6dde6bc7318ff0ac70026496"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.12/tagmails-0.2.12-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "4aab1417d6d46f17b49725884038f4c1fc99d78d0190e778a687ef32f5c53610"
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
