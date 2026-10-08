class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.19"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.19/tagmails-0.2.19-aarch64-apple-darwin.tar.gz"
    sha256 "d787f2cf985caf4cc67e2bece5e86e53ba6e3a2dc02637e0e4ffd19d79b8ce70"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.19/tagmails-0.2.19-x86_64-apple-darwin.tar.gz"
    sha256 "e5ad158f04776de0cadf09e97ed6b080afa13ab87e10947b7c4f8847a9d2d5a9"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.19/tagmails-0.2.19-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "9bdb103d862186c0cf10a4662db56a5471436c1942e522bff906f5fc7b676fec"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.19/tagmails-0.2.19-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "984eaa4d59b33d52d612d4641c5503f6d113710ae945da19e5c01ad18d18105f"
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
