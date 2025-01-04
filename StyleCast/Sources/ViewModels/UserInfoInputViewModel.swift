import Foundation
import Combine

class UserInfoInputViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var age: String = ""
    @Published var selectedGender: Gender? = nil

    private let coreDataStorage = CoreDataStorage()

    func register() {
        // TODO: - CoreDataに保存する処理を書く
        let context = coreDataStorage.saveContext()

        // 新しい User エンティティを作成
        let newUser = User(context: context)
        newUser.username = username
        newUser.age = age
        newUser.selectedGender = selectedGender?.rawValue ?? ""
    }
}
