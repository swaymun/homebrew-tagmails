class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.15"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.15/tagmails-0.2.15-aarch64-apple-darwin.tar.gz"
    sha256 "aef7df490551b12db1f80299f88de51594703da574a6fdc4461452570aff0113"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.15/tagmails-0.2.15-x86_64-apple-darwin.tar.gz"
    sha256 "34a98205472a5fdb163ce97aa6fb5d52cbdc43802487fd3a95f500a92d635b30"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.15/tagmails-0.2.15-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "74dbe63b30c461b044cd466479d2d19d254f401afd022cd1144a5aadf123fdb6"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.15/tagmails-0.2.15-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e1099e3d7d10e05d32bdb4390f344c49eb723eac2e57caf6ce07581881b68d56"
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
