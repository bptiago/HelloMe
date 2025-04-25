import SwiftUI

struct BoardView: View {
    var key: String
    private let images: [ImageModel]
    
    init(key: String) {
        self.key = key
        images = Array(1...6).map { ImageModel(name: "\(key)\($0)", zIndex: $0)}
    }
    
    var body: some View {

        ZStack {
            Image(key)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
           
            ForEach(images) { image in
                DraggableView(image: image, bringToFront: {
                    bringToFront(image)
                })
            }
        }
    }
    
    private func bringToFront(_ selectedImage: ImageModel) {
        // Diminui o zPosition de cada imagem do array, se for maior que o da imagem selecionada
        for image in images {
            if image.zIndex > selectedImage.zIndex {
                image.zIndex -= 1
            }
        }
        selectedImage.zIndex = images.count
    }
}
