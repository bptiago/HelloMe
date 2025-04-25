import SwiftUI

struct DataSource {    
    private static let iconImages = [
        "emoji_cinema1",
        "emoji_cinema2",
        "emoji_music1",
        "emoji_music2",
        "emoji_me1",
        "emoji_me2"
    ]
    
    func getIconImages() -> [String] {
        return Self.iconImages
    }
}
