cask "budget-guard" do
  version "2.0.1"
  sha256 "f7c30309e82faf4bbe858a566ea24bbc3d0f960bd3907d882f574cb76fcc7de3"

  url "https://github.com/dalex160/claude-budget-watch/releases/download/v#{version}/BudgetGuard-#{version}.dmg"
  name "Budget Guard"
  desc "Menu bar app showing how much of your weekly Claude limit you have used"
  homepage "https://dalex160.github.io/claude-budget-watch/"

  livecheck do
    url "https://dalex160.github.io/claude-budget-watch/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :ventura

  app "Budget Guard.app"

  zap trash: [
    "~/Library/Caches/com.alexisdahan.BudgetGuard",
    "~/Library/HTTPStorages/com.alexisdahan.BudgetGuard",
    "~/Library/Preferences/com.alexisdahan.BudgetGuard.plist",
    "~/Library/WebKit/com.alexisdahan.BudgetGuard",
  ]

  caveats <<~EOS
    Première ouverture : macOS refuse d'ouvrir Budget Guard, c'est normal.
    Réglages Système > Confidentialité et sécurité > « Ouvrir quand même ».
    Explications en images : https://dalex160.github.io/claude-budget-watch/
  EOS
end
