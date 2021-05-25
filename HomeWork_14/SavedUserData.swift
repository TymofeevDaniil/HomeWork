
import Foundation
class SavedUserData{
    
    static let shared = SavedUserData()
    private let kSavedNameKey = "SavedUserData.kSavedNameKey"
    private let kSavedSurnameKey = "SavedUserData.kSavedSurnameKey"
    
    var savedName: String?{
        set {UserDefaults.standard.set(newValue, forKey: kSavedNameKey)}
        get {return UserDefaults.standard.string(forKey: kSavedNameKey)}
    }
    var savedSurname: String?{
        set {UserDefaults.standard.set(newValue, forKey: kSavedSurnameKey)}
        get {return UserDefaults.standard.string(forKey: kSavedSurnameKey)}
    }
    
}
