
import Foundation
import RealmSwift

class Task: Object{
    @objc dynamic var item = String()
    @objc dynamic var done = Bool()
}
