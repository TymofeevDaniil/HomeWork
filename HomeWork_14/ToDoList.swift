
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
        for (_, task) in allTasks.enumerated(){
            list.append(task.item)
        }
        return list
    }
    func save(list: [String]){
        let savedTask = ToDoList()
        let oldItems = realm.objects(ToDoList.self)
        try! realm.write{
            realm.delete(oldItems)
            for task in list{
                savedTask.item = task
                realm.add(savedTask)
                print(realm.objects(ToDoList.self))
            }
        }
    }
    
}
