class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your Tagmails address"
  homepage "https://tagmails.com"
  version "0.2.30"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.30/tagmails-0.2.30-aarch64-apple-darwin.tar.gz"
    sha256 "76ae160bcb690cc263e24a7596822a4a379568ecd4f280dbf7172bda9ebebd44"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.30/tagmails-0.2.30-x86_64-apple-darwin.tar.gz"
    sha256 "2fd2560d3d1d6be356d1a8d6fc9b41befdbb1249d695ec2559360158c6ed8cee"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.30/tagmails-0.2.30-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "5546108f7ecba41630ff2e025fc7d41d00ca63380b1e5652629d8c6902ac7aa8"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.30/tagmails-0.2.30-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "aab1e25c4e31024095229dd69d33316686b4bf7de6bb7a232276c3fc9da7e020"
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
