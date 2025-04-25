import SwiftUI

class ImageModel: ObservableObject, Identifiable {
    let id = UUID() 
    let name: String
    let scale = 0.35
    let rotation = Angle(degrees: Double.random(in: -10...10))
    
    // O wrapper @Published é necessário para que as views sejam atualizadas caso algum desses valores mude
    @Published var zIndex: Int
    @Published var isDragging: Bool = false
    @Published var position: CGPoint?
    
    init(name: String, zIndex: Int) {
        self.name = name
        self.zIndex = zIndex
    }
}
