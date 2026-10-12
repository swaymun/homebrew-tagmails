class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.23"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.23/tagmails-0.2.23-aarch64-apple-darwin.tar.gz"
    sha256 "b5199a8c824387d2b97846bf3f697fee217258bdb752ec715d2d7c55f51e91d5"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.23/tagmails-0.2.23-x86_64-apple-darwin.tar.gz"
    sha256 "eba27309d2e216a5036ee9c1ef59076c6f91fe25ff7c98ad7934d4772773aed5"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.23/tagmails-0.2.23-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "fb920134dfd092c38a86b037d1cf1336d6aaf51b335dcc7049992dccacb50a32"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.23/tagmails-0.2.23-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ee05d2aa62bb976e43b071298341f58ed66106caef9e8bd13cbf5cfc28786524"
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
