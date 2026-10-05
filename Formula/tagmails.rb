class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.0/tagmails-0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "ebdac4ab155325f9e75a268157582febc6f8696a67ef10046d0b4e84401bc981"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.0/tagmails-0.2.0-x86_64-apple-darwin.tar.gz"
    sha256 "7d147496880602b39b1a11be31b3e3461f9d8cde5e54a9370f56095938882ae8"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.0/tagmails-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "87df31d47c0f2bd622bad671982baab20cf6f84f873e83fc8681e396b861e4e9"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.0/tagmails-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "851357e00e456ad4119a5a03795d970b2c1a2fcde410c288bf3b8a281e5967eb"
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
