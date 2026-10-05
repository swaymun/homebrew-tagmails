class Tagmails < Formula
  desc "Email your coding agent: runs Codex or Claude Code for mail sent to your TagMails address"
  homepage "https://tagmails.com"
  version "0.2.9"
  license "MIT"

  on_macos do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.9/tagmails-0.2.9-aarch64-apple-darwin.tar.gz"
    sha256 "84bd7c33d547c99f76848bc92cb4e4a0e611535f38193fd199e9e71f6c6c3a3d"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.9/tagmails-0.2.9-x86_64-apple-darwin.tar.gz"
    sha256 "c909cdf954bed94a68e7455165e9af75ca9c626a13d27e69122fbd8706e96023"
    end
  end

  on_linux do
    on_arm do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.9/tagmails-0.2.9-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "b2d44da6eacca36a307ac20c3320fa80d857d680f64fec0d952c48f00fb6ed14"
    end
    on_intel do
    url "https://github.com/swaymun/homebrew-tagmails/releases/download/v0.2.9/tagmails-0.2.9-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "aa3e1d2d5efdc3733ce6274d559b997732871344f49f112bb857cca22d054c30"
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
