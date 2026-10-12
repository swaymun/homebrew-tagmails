class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.24"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.24/tagmails-0.2.24-aarch64-apple-darwin.tar.gz"
    sha256 "9579a6b0cab7fe203353b7c4812f3fd154020deeff1d6f60393807a2d6c461b1"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.24/tagmails-0.2.24-x86_64-apple-darwin.tar.gz"
    sha256 "a06a9d6c163066c77a402f15b6028ef3a30cbaad779c466cb7c07bc1b63bd130"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.24/tagmails-0.2.24-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "7dbc143c5d0036a5c4faca9c29496c621954284af807a064fa5feca29442cafb"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.24/tagmails-0.2.24-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "af834bc13e5ac1f339a1d681f3deec0026c521e43cdf4304815c27a2d38809e5"
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
