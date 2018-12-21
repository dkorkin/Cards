import Foundation
import UIKit

class CardViewModel {
    var card: Card?
    var imageFrame: CGRect?
    var labelFrame: CGRect?
    
    init(card: Card?, imageFrame: CGRect?, labelFrame: CGRect?) {
        self.card = card
        self.imageFrame = imageFrame
        self.labelFrame = labelFrame
    }
}
