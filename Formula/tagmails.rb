class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.17"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.17/tagmails-0.2.17-aarch64-apple-darwin.tar.gz"
    sha256 "2ad16be7abf23b03a479d5debdd7c1b965c9f85bc5f5e259cefb3aa3f3542191"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.17/tagmails-0.2.17-x86_64-apple-darwin.tar.gz"
    sha256 "5eadbce36a5f272421be1d11719c634921a90efd1f7f516be1635a879d1788c1"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.17/tagmails-0.2.17-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "268401adddc8bfda45bffad18577c5a7680c9a3fd3a912466364138d58ade80a"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.17/tagmails-0.2.17-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "59fc1e15dc41823097ff280f8c9a08b1767e367704a8bf5c4fe366d2b89435ca"
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
