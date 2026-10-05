class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.3"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.3/tagmails-0.2.3-aarch64-apple-darwin.tar.gz"
    sha256 "2fe6b57219b453d47a757adb31b5444a8bf0291aed2cf468af09b4917d5e9787"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.3/tagmails-0.2.3-x86_64-apple-darwin.tar.gz"
    sha256 "80fed5c0827dc45546d31d80ba5a5dbf940a2f824abc894017e5f28d57d8d1bc"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.3/tagmails-0.2.3-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "89c210629f0d649692ed15573ceec7c638d9c875ba858f0f2dde00632775a243"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.3/tagmails-0.2.3-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d61ee1eca09c1a48b1c56f392605868cb678685e06634ea90b8a9177719957fd"
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
