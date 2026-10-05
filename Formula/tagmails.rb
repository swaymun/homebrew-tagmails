class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.2"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.2/tagmails-0.2.2-aarch64-apple-darwin.tar.gz"
    sha256 "4802d9875f4e006d071ce3b62445eeb98bf717746860fc924a57db857c79c434"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.2/tagmails-0.2.2-x86_64-apple-darwin.tar.gz"
    sha256 "bc33e1b9220331f67169ad4b9395ec0a97a56a3609d8679a9724dd268371c6ea"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.2/tagmails-0.2.2-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "630f911fd617916f29de9f03477ba3ca66500e349f10acbe98f10fdaf23addaa"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.2/tagmails-0.2.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0ca8e208059aaddaea0969519723c4e67fca30bad1cfd4372bb2621f884bb9f5"
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
