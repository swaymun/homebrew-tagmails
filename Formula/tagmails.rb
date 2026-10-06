class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.13"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.13/tagmails-0.2.13-aarch64-apple-darwin.tar.gz"
    sha256 "126391744b53e64703b3e41867692cd0e439fd92b03190bd680c86ebc922eaff"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.13/tagmails-0.2.13-x86_64-apple-darwin.tar.gz"
    sha256 "bb0a1c99e82ee84fa613ab0bb64936fa0d1b913e223f8f6aa5bd8f633902e227"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.13/tagmails-0.2.13-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "fa8603c49f6c2c529ab4de23e1df41d71acb96f7c14b34854979050a2c5449ad"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.13/tagmails-0.2.13-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0f0573e8938d5b8f8ab03916c161a7feee1e1177615d22f09f12e6914639cbd9"
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
