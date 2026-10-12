class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.22"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.22/tagmails-0.2.22-aarch64-apple-darwin.tar.gz"
    sha256 "89a16566d329e3e63c22ba663bb03f85d16fcf8917307bb4292599a5c80f3668"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.22/tagmails-0.2.22-x86_64-apple-darwin.tar.gz"
    sha256 "0bf26d2cbf8242c94c9a4ee753a70c32c38bbf35ded7e490efe6731bdbdd1cb5"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.22/tagmails-0.2.22-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "406a1c5c8d02754fad2f62735535adb862a9fa794ab5a15596febd55204a572f"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.22/tagmails-0.2.22-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "3b7df6102e8d7beff004fe36cefebef96b8517422dba071df94e7803629ad852"
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
