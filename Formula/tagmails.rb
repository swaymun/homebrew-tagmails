class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.28"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.28/tagmails-0.2.28-aarch64-apple-darwin.tar.gz"
    sha256 "936404d02c98d163ada4151e0460391d34c822998ab4a421772a06f2dc63a996"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.28/tagmails-0.2.28-x86_64-apple-darwin.tar.gz"
    sha256 "a1d740ddb27463feca484f39f672fcb2052aadf2a21a3e69ba86f2fa7d4a64ef"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.28/tagmails-0.2.28-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "707b2399cabb910621de18097e298226e869259bb43597d10cd461cab1e9f2cb"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.28/tagmails-0.2.28-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b6b63861bd17161447c5781faaf9c43d0fe43d09bcdfe89800583ad6e836b7d8"
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
