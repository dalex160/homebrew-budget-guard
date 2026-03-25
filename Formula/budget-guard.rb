class BudgetGuard < Formula
  desc "SwiftBar plugin showing Claude Max usage in the macOS menu bar"
  homepage "https://github.com/dalex160/claude-budget-watch"
  url "https://github.com/dalex160/claude-budget-watch/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "bcd6ea26668de0ad5b6861867d9a45e4a8aa32b8ebbd0d9bffbffbc43b0b0926"
  license "MIT"

  depends_on :macos
  depends_on "python@3"

  def install
    bin.install "budget-guard.2m.sh"

    # Install a helper script that links the plugin into SwiftBar
    (bin/"budget-guard-link").write <<~SH
      #!/bin/bash
      set -euo pipefail
      PLUGINS_DIR="$HOME/Library/Application Support/SwiftBar/Plugins"
      mkdir -p "$PLUGINS_DIR"
      ln -sf "#{bin}/budget-guard.2m.sh" "$PLUGINS_DIR/budget-guard.2m.sh"
      echo "Linked budget-guard into SwiftBar plugins directory."
      if ! pgrep -x SwiftBar >/dev/null 2>&1; then
        echo "Starting SwiftBar..."
        open -a SwiftBar 2>/dev/null || echo "SwiftBar not found. Install it: brew install --cask swiftbar"
      else
        echo "SwiftBar is running. The plugin will appear on next refresh."
      fi
    SH
    chmod 0755, bin/"budget-guard-link"
  end

  def caveats
    <<~EOS
      To complete setup, run:
        budget-guard-link

      This links the plugin into SwiftBar's plugin directory and starts SwiftBar.

      Prerequisites:
        - SwiftBar must be installed: brew install --cask swiftbar
        - Claude Code must have been authenticated at least once (OAuth token in Keychain)

      To enable debug logging:
        export BUDGET_GUARD_DEBUG=1

      Logs: ~/.claude/budget-guard.log
    EOS
  end

  test do
    assert_match "Budget Guard", shell_output("head -10 #{bin}/budget-guard.2m.sh")
  end
end
