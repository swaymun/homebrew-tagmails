class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.1/tagmails-0.2.1-aarch64-apple-darwin.tar.gz"
    sha256 "5b199bfff7da7625b4aebbd2bdfb1d0dc3adcf58e4752972e6bd71fb5ebf5d6a"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.1/tagmails-0.2.1-x86_64-apple-darwin.tar.gz"
    sha256 "6f6c9c6a3c7d6edcc457b704a0737deaedde2ae31d83a6ad860816b606b67a67"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.1/tagmails-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "2c0e47184fc0e1bb06d74d737c5cc226106cd23781e0af207a73ad59b12120ec"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.1/tagmails-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "86896f1a9abf4e07f311ac2918aa69fc1c0177dbd162a3157d37c37ec524263a"
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
