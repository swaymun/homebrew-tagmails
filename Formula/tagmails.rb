class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.4"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.4/tagmails-0.2.4-aarch64-apple-darwin.tar.gz"
    sha256 "fc90637fe52c81d0e11c34bec11bf89363acb6a81cac7e0c3127390231a63155"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.4/tagmails-0.2.4-x86_64-apple-darwin.tar.gz"
    sha256 "d1d8de9e3983ffadc9f13548e7055e63b8d6997972112209fe503a28e448f07c"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.4/tagmails-0.2.4-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "0a27221949d051b603f97670941d1654cfab5106fba5d8878fa9aef6c6de6146"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.4/tagmails-0.2.4-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "8a4d53ce9c30a83c25e60db85c2b8ff1ea17a5a5b78ef0e8d6c676151d35513e"
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
