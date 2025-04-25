import SwiftUI

// Não consigo fazer a troca de tela por @State na main. Precisei dessa ROOT
struct AppRootView: View {
    @State private var gameState: GameState = .start
    
    var body: some View {
        switch gameState {
        case .start:
            StartView(gameState: $gameState)
        case .playing:
            ContentView(dataSrc: DataSource(), gameState: $gameState)
        case .end:
            EndingView(gameState: $gameState)
        }
    }
}
