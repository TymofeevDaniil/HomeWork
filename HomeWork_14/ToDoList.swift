
import Foundation
import RealmSwift

class ToDoList: Object{
    @objc dynamic var item = String()
}
class Persistance{
    static let shared = Persistance()
    private let realm = try! Realm()
    
    func load() -> [String]{
        var list = [String]()
        let allTasks = realm.objects(ToDoList.self)
        for task in allTasks{
            list.append(task.item)
        }
        return list
    }
    func save(list: [String]){
        print(list)
        let savedTask = ToDoList()
        print(savedTask)
        let oldItems = realm.objects(ToDoList.self)
        try! realm.write{
            realm.delete(oldItems)
        }
        for task in list{
            try! realm.write{
            savedTask.item = task
            realm.add(savedTask)
            }
        }
        print(realm.objects(ToDoList.self).count)
    }
    
}
