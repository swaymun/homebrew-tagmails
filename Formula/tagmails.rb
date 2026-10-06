class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.14"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.14/tagmails-0.2.14-aarch64-apple-darwin.tar.gz"
    sha256 "0e06490a362fb24cc8ce24db899e5741ffe24ec0ee882202edc7cee7e3da3135"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.14/tagmails-0.2.14-x86_64-apple-darwin.tar.gz"
    sha256 "9ddd232546efa565f5fd34d0c135c0929b1567d711840db346e93565bd354bd8"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.14/tagmails-0.2.14-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "bebe7681949fffdca2ed32d13b4df4809026db295ba15d2e3cc4504ddfc8cb84"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.14/tagmails-0.2.14-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ce1ff40737f751bf7eb5371430faf5c317244dbb3a14fda6142d5b60d9a7d05d"
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
