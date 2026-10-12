class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.20"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.20/tagmails-0.2.20-aarch64-apple-darwin.tar.gz"
    sha256 "9b9a334631bccd82a246a57f9e6e42f2b8af89e4061c5a256cceffa5d81453fb"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.20/tagmails-0.2.20-x86_64-apple-darwin.tar.gz"
    sha256 "3c564d2c57131b83849f39d8a334b3dffabef6bdea2f7974ca3f5d48649d5baa"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.20/tagmails-0.2.20-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "0cd1fe530b448707301d04d47e78250d9ab7ac28175dca0a81d05119e3c7eb3f"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.20/tagmails-0.2.20-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b46ab2f1687c6607a89ccb157370422a3e6d22191c3cd85cd5f627b4092de924"
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
