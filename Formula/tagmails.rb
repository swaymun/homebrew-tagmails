class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.16"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.16/tagmails-0.2.16-aarch64-apple-darwin.tar.gz"
    sha256 "c1dfd7816ebf3eabbc7c5f1926f7bb28a6ae3d37aeaeff75d7b4cf9b4bb9f569"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.16/tagmails-0.2.16-x86_64-apple-darwin.tar.gz"
    sha256 "bff52c72824e37f4df8be78f6b1fd3814ee6bb3bb48721128f230bedde376263"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.16/tagmails-0.2.16-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "1d229b9f34332508a80fbf11ae233b42d9f29d5c1ef60d8c5be8dbea3bcf14a7"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.16/tagmails-0.2.16-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "27444f0f9e8b31e23333dbae220d2b877865bbe6b4f834caf92ace027879c20f"
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
