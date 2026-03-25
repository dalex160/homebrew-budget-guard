class BudgetGuard < Formula
  desc "SwiftBar plugin showing Claude Max usage in the macOS menu bar"
  homepage "https://github.com/dalex160/claude-budget-watch"
  url "https://github.com/dalex160/claude-budget-watch/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "bcd6ea26668de0ad5b6861867d9a45e4a8aa32b8ebbd0d9bffbffbc43b0b0926"
  license "MIT"

  depends_on :macos
  depends_on "python@3"
  depends_on cask: "swiftbar"

  def install
    bin.install "budget-guard.2m.sh"
  end

  def post_install
    plugins_dir = Pathname.new("#{Dir.home}/Library/Application Support/SwiftBar/Plugins")
    plugins_dir.mkpath
    target = plugins_dir/"budget-guard.2m.sh"
    target.unlink if target.exist? || target.symlink?
    target.make_symlink(bin/"budget-guard.2m.sh")
  end

  def caveats
    <<~EOS
      Budget Guard has been installed and linked into SwiftBar's plugin directory.

      Prerequisites:
        - Claude Code must have been authenticated at least once (OAuth token in Keychain)
        - SwiftBar must be running

      Start SwiftBar if it's not already running:
        open -a SwiftBar

      To enable debug logging:
        export BUDGET_GUARD_DEBUG=1

      Logs: ~/.claude/budget-guard.log
    EOS
  end

  test do
    assert_match "Budget Guard", shell_output("head -10 #{bin}/budget-guard.2m.sh")
  end
end
