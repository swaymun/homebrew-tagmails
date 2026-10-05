class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.6"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.6/tagmails-0.2.6-aarch64-apple-darwin.tar.gz"
    sha256 "1650288d63cb3f818c60f8f4b96dee445ac3f77db646b9546ffa4ced21352831"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.6/tagmails-0.2.6-x86_64-apple-darwin.tar.gz"
    sha256 "7407ae4dfef80e1621471683f00468c82a1ad4db8daaca48c6ced308e0527a3d"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.6/tagmails-0.2.6-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "e3a2d064c1bff607d0a0a453cea48efb89932a24700ffb9bf90804881dd17359"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.6/tagmails-0.2.6-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "66b5564048987e5be83064e96be8bbd1884d147e301a62ef8effb2e72c89a0e3"
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
