import Foundation

enum Gender {
    case male
    case female

    var value: String {
        switch self {
        case .male:
            return "male"
        case .female:
            return "female"
        }
    }
}
