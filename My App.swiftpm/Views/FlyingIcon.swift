import SwiftUI

struct FlyingIcon: View {
    var imageName: String
    var onTapped: (String) -> Void
//    var resetTrigger: UUID
    
    @State private var xOffset: CGFloat = -400
    @State var yOffset: CGFloat = CGFloat.random(in: -400...0)
    @State private var hasFallen = false
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 80)
            .offset(x: xOffset, y: yOffset)
            .onTapGesture {
                fall()
                onTapped(imageName)
            }
            .onAppear {
                if !hasFallen {
                    slideAnimation()
                }
            }
            
    }
    
    private func slideAnimation() {
        withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
            xOffset = 400
        }
    }
    
    private func fall() {
        hasFallen = true
        
        SFXPlayer.manager.playSound(fileName: "pop", format: "mp3")
        
        withAnimation(.easeIn(duration: 1)) {
            xOffset = 0
            yOffset = 200
        }
    }
    
//    private func reset() {
//        isHidden = false
//        hasFallen = false
//        
//        xOffset = -400
//        yOffset = CGFloat.random(in: -400...0)
//        
//        slideAnimation()
//    }
    
}
