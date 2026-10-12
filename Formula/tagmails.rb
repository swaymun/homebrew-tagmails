class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.26"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.26/tagmails-0.2.26-aarch64-apple-darwin.tar.gz"
    sha256 "69097f971505b269dd58ccc593820f2ce46a5404ac57f9c45948255d3fc40d20"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.26/tagmails-0.2.26-x86_64-apple-darwin.tar.gz"
    sha256 "6a88bc7e034331db859f8189483fe3f5beca1374497d7271f87c51f093d1ad1b"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.26/tagmails-0.2.26-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "ce9e29f1ec01e6bb4a17f86793563edf528eb599d13c559fcd70f8ce69190a8f"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.26/tagmails-0.2.26-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e3775faa8e3fa7930b7358024f0d95bebb32729370a50363d47254b630d1d7bf"
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
