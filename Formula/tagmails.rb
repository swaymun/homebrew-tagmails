class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.21"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.21/tagmails-0.2.21-aarch64-apple-darwin.tar.gz"
    sha256 "1e56f67c605e7333d836af04670849fe05917bdb14e4b68b5bb9a8d5e9e1b1a9"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.21/tagmails-0.2.21-x86_64-apple-darwin.tar.gz"
    sha256 "44a0374978371db711569a9b90568b5d7f467f56ca221cb77eb301419812a9d4"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.21/tagmails-0.2.21-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "145eef474dcf3c72841bcf4fd55a478bbeb2789964416a8290af5c1984969fb5"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.21/tagmails-0.2.21-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b9de352afd1569169ccc3a201b617ae6f6ffa2d9edb4e0c33f75b0560ef3077f"
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
