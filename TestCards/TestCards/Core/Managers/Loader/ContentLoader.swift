import Foundation

class ContentLoader {
    class func cards() -> [Card]? {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                if let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    return try Response(object: jsonObj).cards
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }
}
