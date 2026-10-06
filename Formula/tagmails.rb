class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.11"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.11/tagmails-0.2.11-aarch64-apple-darwin.tar.gz"
    sha256 "abbf2d07c0457c5f08ce960125f657c732f5ba9a89aa97bf36fd297cc279adee"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.11/tagmails-0.2.11-x86_64-apple-darwin.tar.gz"
    sha256 "6b911972756c9da07bdaf51231cf3ab3b8a7f85ef4ce20100fd0ac9682ad3eee"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.11/tagmails-0.2.11-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "507914ec82851a99672f2f3eef26c39e9d7945681cf21d9903d0038b9a79212b"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.11/tagmails-0.2.11-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "6b24196ae3db5bba1f581b40ba16f22896907ab65a28b47d1334c169e802824b"
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
