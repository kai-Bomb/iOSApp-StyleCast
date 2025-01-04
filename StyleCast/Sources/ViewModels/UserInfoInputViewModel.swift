import Foundation
import Combine

class UserInfoInputViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var age: String = ""
    @Published var selectedGender: Gender? = nil

    func register() {
        // ToDo: CoreDataに保存する処理を書く
    }
}
