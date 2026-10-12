class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.25"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.25/tagmails-0.2.25-aarch64-apple-darwin.tar.gz"
    sha256 "3454cda218caea7ecb29cd0b561805fb1489af871f336e2fc95a1340046b4efc"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.25/tagmails-0.2.25-x86_64-apple-darwin.tar.gz"
    sha256 "638a06f501082001bdf1a0a22c567fe6b4602b9c903b5418b974786b2afb530c"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.25/tagmails-0.2.25-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "cc88b4c406ea49ce9aa62638a98ad6b3590acf2b253b970885e5a4048a668bcd"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.25/tagmails-0.2.25-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e1f2bb4731c00395ffa04f6cd46f87e04ad2b692b2a903b23341ff81a57e7f68"
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
