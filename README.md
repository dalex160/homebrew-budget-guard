# Homebrew Tap for Budget Guard

[Budget Guard](https://github.com/dalex160/claude-budget-watch) is a Mac app that shows, in the menu bar, how much of your weekly Claude limit you have used. It updates itself.

## Install

```bash
brew tap dalex160/budget-guard
brew trust dalex160/budget-guard
brew install budget-guard
```

First launch: macOS refuses to open it once. Open System Settings > Privacy & Security and click « Open Anyway ». Pictures: https://dalex160.github.io/claude-budget-watch/

This tap used to install the old SwiftBar plugin; it now installs the native app.

## Uninstall

```bash
brew uninstall budget-guard
brew untap dalex160/budget-guard
```
