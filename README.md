# TagMails Homebrew tap

Install the TagMails agent, which runs Codex or Claude Code on your computer for emails sent to your TagMails address:

```sh
brew install swaymun/tagmails/tagmails
```

Then create a pairing code at https://tagmails.com/setup and run:

```sh
tagmails pair <code>
tagmails start
```

Without Homebrew: `curl -fsSL https://tagmails.com/install.sh | sh` (needs Node.js 20+).

Releases hold prebuilt binaries for macOS and Linux (arm64, x86_64), the agent's Node adapters, and a source archive. MIT licensed.
