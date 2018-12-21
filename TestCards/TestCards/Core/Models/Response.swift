import Foundation
import Marshal

class Response: Unmarshaling {
    var cards: [Card]
    
    required init(object: MarshaledObject) throws {
        self.cards = try object.value(for: "cards")
    }
}
