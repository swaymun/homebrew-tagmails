class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.29"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.29/tagmails-0.2.29-aarch64-apple-darwin.tar.gz"
    sha256 "e829bd5cf048cb93afb464fb81d260856c84ad21f18a3c4698fa4c6a9057e57d"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.29/tagmails-0.2.29-x86_64-apple-darwin.tar.gz"
    sha256 "d696da6c9bac7c6d696806d455a5297bbb623a9a2d75ca5c9094fe34dc9c1eb2"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.29/tagmails-0.2.29-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "e1e141c3ecc5b5422f57d71ead31e5be6c93d7ed071477d6f23d64ee2065473c"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.29/tagmails-0.2.29-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "44aa5129e93e0556dc4cc0bc30a3f88ca197b6cf1de5aae4e5600eedd3209375"
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
