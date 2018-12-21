import Foundation
import Marshal

class Card: Unmarshaling {
    var title: String
    var content: String
    var imageName: String
    
    required init(object: MarshaledObject) throws {
        self.title = try object.value(for: "title")
        self.content = try object.value(for: "content")
        self.imageName = try object.value(for: "image")
    }
}
