class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.7"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.7/tagmails-0.2.7-aarch64-apple-darwin.tar.gz"
    sha256 "c8bc510dfb27dd3bea309ad8404c01ee74bcb8c8c25364a2fedadcbcb1dcf1da"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.7/tagmails-0.2.7-x86_64-apple-darwin.tar.gz"
    sha256 "e2647dc0231f266aa40b6531c181852d8893a5623f6e34bd318a4d51c03ec2aa"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.7/tagmails-0.2.7-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "f45e413d632c5aed74ebd686fea46074bfc52e684b6548ea92724a8894218e47"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.7/tagmails-0.2.7-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b9baeb8c7e58d61ccfef9e7f7ea536a7c71a8cab19754d52d033b6777d3b7a75"
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
