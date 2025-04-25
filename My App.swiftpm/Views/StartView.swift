import SwiftUI

struct StartView: View {
    private let ACCENT_COLOR: Color = .teal
    private let FONT_COLOR: Color = .softBeige
    
    @Binding var gameState: GameState;
    @State var isTextHidden = true
    @State var isCurtainClosed = true
    @State var xOffset: CGFloat = 500
    
    
    var title: some View {
        Text("Hello, ")
        + Text("Me")
            .foregroundStyle(ACCENT_COLOR)
        + Text("!")
    }
    
    var description: some View {
        Text("Seu objetivo é ") 
        + Text("encontrar as três receitas que refletem os interesses do Tiago")
            .foregroundStyle(ACCENT_COLOR)
            .fontWeight(.semibold)
            .italic()
        + Text(". Cada receita é formada por dois ingredientes e, ao acertar uma combinação, você será levado a uma tela interativa. Se você acertar todas as combinações, você vence!")
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
                     
                 Text("Ao continuar, você precisará ser um chef de cozinha!")
                     .font(.title2)
                     .multilineTextAlignment(.center)
                     .padding(.top, 5)
                     .foregroundStyle(FONT_COLOR)
                     
                 description
                     .multilineTextAlignment(.center)
                     .padding()
                     .foregroundStyle(FONT_COLOR)
                     
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
