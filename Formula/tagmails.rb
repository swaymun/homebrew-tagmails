class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.8"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.8/tagmails-0.2.8-aarch64-apple-darwin.tar.gz"
    sha256 "adee3d9a44fcfa36d1f307ee2f33aab004be62d91794a215ed996934e90478b7"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.8/tagmails-0.2.8-x86_64-apple-darwin.tar.gz"
    sha256 "2b8fdef0deb1d0de052e687ff685c8b9faf7345a4af795f4293939a60829304e"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.8/tagmails-0.2.8-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "43ce7101739d3f650a67b9596b31eb029ecbb9be3462e5e3b50cd52973145bc3"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.8/tagmails-0.2.8-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c1d515129969ebd55014a8830321d0b6dc2e83a7f70dc1c134e9b663ad64ab57"
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
