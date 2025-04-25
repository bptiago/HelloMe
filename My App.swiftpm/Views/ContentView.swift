import SwiftUI

enum Screen: Hashable {
    case result(key: String)
}

struct ContentView: View {
    let dataSrc: DataSource
    
    @State private var yOffsets: [CGFloat] = []
    @State private var tappedImages: [String] = []
    @State private var path: [Screen] = []
    @State private var resetTrigger: UUID = UUID()
    @State private var combosFound: Int = 0
    @State private var isScreenHidden = true
    @Binding var gameState: GameState;
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Image("kitchen")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                ForEach(Array(zip(dataSrc.getIconImages().shuffled(), yOffsets)), id: \.0) { imageName, yOffset in
                    FlyingIcon(
                        imageName: imageName,
                        onTapped: onTapped,
                        yOffset: yOffset
                    )
                    .id("\(resetTrigger)-\(imageName)")
                    // isso faz o reset da view de tds os ícones
                    // melhor que usar o reset()
                }
                
                Image("pot")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220)
                    .frame(maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.bottom, 100)
            }
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                case .result(let key):
                    BoardView(key: key)
                        .onDisappear() {
                            checkEnding()
                        }
                }
            }
        }
        .opacity(isScreenHidden ? 0 : 1)
        .onAppear {
            if yOffsets.isEmpty {
                yOffsets = generateNonOverlappingOffsets(count: dataSrc.getIconImages().count)
            }
            
            withAnimation(.smooth(duration: 2)) {
                isScreenHidden = false
            }
        }
    }
    
    private func onTapped(_ img: String) -> Void {
        tappedImages.append(img)
        
        if tappedImages.count < 2 { return }
        let duo = tappedImages.suffix(2)
        if duo.contains("emoji_cinema1") && duo.contains("emoji_cinema2") {
            changeScreen("cinema")
            combosFound += 1
        } else if duo.contains("emoji_music1") && duo.contains("emoji_music2") {
            changeScreen("music") 
            combosFound += 1
        } else if duo.contains("emoji_me1") && duo.contains("emoji_me2") {
            changeScreen("me")
            combosFound += 1
        } else {
            SFXPlayer.manager.playSound(fileName: "wrong", format: "wav")
            resetIcons()
        }
        
        tappedImages = []   
    }
    
    private func checkEnding() {
        if combosFound == 3 {
            gameState = .end
        }
    }
    
    private func resetIcons() {
            resetTrigger = UUID()
            combosFound = 0
    }
    
    private func changeScreen(_ key: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            path.append(.result(key: key))
            SFXPlayer.manager.playSound(fileName: "correct", format: "wav", volume: 2.0)
        }
    }
    
    private func generateNonOverlappingOffsets(count: Int, minY: CGFloat = -340, maxY: CGFloat = 100) -> [CGFloat] {
        let sectionHeight = (maxY - minY) / CGFloat(count)
        var positions: [CGFloat] = []
        
        for i in 0..<count {
            let min = minY + CGFloat(i) * sectionHeight
            let max = min + sectionHeight
            let randomY = CGFloat.random(in: min...(max - 60)) // distancia entre linhas
            positions.append(randomY)
        }
        
        return positions.shuffled()
    }
}
