class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.27"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.27/tagmails-0.2.27-aarch64-apple-darwin.tar.gz"
    sha256 "1afaa0ae3b9d013d90d5b29e21e480748e7535ddb21a4db042c7c626b6752ba9"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.27/tagmails-0.2.27-x86_64-apple-darwin.tar.gz"
    sha256 "935f22d3c1007d491b44c5c2c6d25dbaa3c6021ff6327f57000250a67dbc024b"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.27/tagmails-0.2.27-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "683da6ee6549203ae3707578f27aaad98657a6f0762d8ac9b230f64cf2030942"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.27/tagmails-0.2.27-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d12b3893c1fe0c67e9278beb93f38af8b6974b28fe82230f86526262f68cf571"
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
