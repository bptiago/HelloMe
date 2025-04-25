import SwiftUI

struct EndingView: View {
    private let ACCENT_COLOR: Color = .teal
    private let FONT_COLOR: Color = .softBeige
    
    @Binding var gameState: GameState;
    @State var isTextHidden = true
    @State var isCurtainClosed = false
    @State var xOffset: CGFloat = 500
    
    
    var title: some View {
        Text("Você conseguiu!")
    }
    
    var description: some View {
        Text("Se você quiser jogar novamente, ") 
        + Text("clique no botão abaixo")
            .foregroundStyle(ACCENT_COLOR)
            .fontWeight(.semibold)
            .italic()
        + Text(".")
    }
    
    var body: some View {
        ZStack {
            Image("right_curtain")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .offset(x: isCurtainClosed ? 0 : xOffset)
            
            Image("left_curtain")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .offset(x: isCurtainClosed ? 0 : -xOffset)
            
            VStack {
                title
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(FONT_COLOR)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 0)
                
                
                Text("Olha, você ainda não é um chef de cozinha, mas pelo menos conhece mais sobre o Tiago!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .foregroundStyle(FONT_COLOR)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 0)
                
                description
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundStyle(FONT_COLOR)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 0)
                
                
                
                Button(action: {
                    startGame()                   
                }) {
                    Text("Jogar")
                        .font(.headline)
                        .foregroundStyle(FONT_COLOR)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(ACCENT_COLOR)
                        .cornerRadius(12)
                        .shadow(color: ACCENT_COLOR.opacity(0.3), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(
               RoundedRectangle(cornerRadius: 20)
                   .fill(Color.black.opacity(0.6))
                   .overlay(
                               RoundedRectangle(cornerRadius: 20)
                                   .stroke(Color.darkRed, lineWidth: 2)
                           )
            )
            .frame(width: 350)
            .opacity(isTextHidden ? 0 : 1)
            .onAppear {
                hideText(false)
                SFXPlayer.manager.playSound(fileName: "finished", format: "wav", volume: 1.2)
                withAnimation(.linear(duration: 4)) {
                    isCurtainClosed = true
                }
            }
        }
    }
    
    private func hideText(_ hide: Bool) {
        withAnimation(.smooth(duration: 1)) {
            isTextHidden = hide
        }
    }
    
    private func startGame() {
        hideText(true)
        
        SFXPlayer.manager.playSound(fileName: "gear", format: "wav")

        withAnimation(.linear(duration: 5)) {
            isCurtainClosed = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            gameState = .playing
        }
        
    }
}
