import SwiftUI

struct DraggableView: View {
    @ObservedObject var image: ImageModel
    var bringToFront: () -> Void
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                image.position = value.location
                // Ao começar a movimentar a imagem, traz ela para o topo
                if !(image.isDragging) {
                    bringToFront()
                    image.isDragging = true
                }
            }
        
            .onEnded { _ in
                image.isDragging = false
            }
    }
    
    var body: some View {
        GeometryReader { geo in // Utilizado para obter propriedades da tela
            Image(image.name)
                .resizable() // Permite a imagem ter tamanho variável
                .scaledToFit()
                .scaleEffect(image.isDragging ? image.scale * 1.1 : image.scale) 
                .position(image.position ?? CGPoint(x: geo.size.width/2, y: geo.size.height/2))
                .rotationEffect(image.rotation)
                .gesture(dragGesture)
                .zIndex(Double(image.zIndex)) // Define a ordem das imagens na ZStack
        }
    }
}
