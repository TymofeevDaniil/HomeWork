
import Foundation
import RealmSwift

class Task: Object{
    @objc dynamic var item = String()
}
class TaskList: Object{
    let list = List<Task>()
}
class Persistance{
    static let shared = Persistance()
    private let realm = try! Realm()
    
    func load() -> [String]{
        print("loaded")
        print(realm.objects(TaskList.self))
        var list = [String]()
        let savedList = TaskList()
        print(savedList.list)
        for task in savedList.list{
            print(task)
            list.append(task.item)
        }
        print(list)
        return list
    }
    func save(list: [String]){
        let oldList = realm.objects(TaskList.self)
        try! realm.write{
            realm.delete(oldList)
        }
        let newList = TaskList()
        try! realm.write{
            for task in list{
                let newTask = Task()
                newTask.item = task
                realm.add(newTask)
                newList.list.append(newTask)
                realm.add(newList)
            }
        }
        print(realm.objects(TaskList.self))
    }
    
}
