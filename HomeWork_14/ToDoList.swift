
import Foundation
import RealmSwift

class Task: Object{
    @objc dynamic var item = String()
    @objc dynamic var done = Bool()
}
class TaskList: Object{
    let list = List<Task>()
}
class Persistance{
    static let shared = Persistance()
    private let realm = try! Realm()
    
    func load() -> ([String], [Bool]){
        print("loaded")
        print(realm.objects(TaskList.self))
        var list = [String]()
        var done = [Bool]()
        guard let savedList = realm.objects(TaskList.self).first else {return ([], [])}
        for task in savedList.list{
            list.append(task.item)
            done.append(task.done)
        }
        print(list)
        return (list, done)
    }
    func save(list: [String], done: [Bool]){
        print("saving")
        let oldList = realm.objects(TaskList.self)
        try! realm.write{
            realm.delete(oldList)
        }
        let newList = TaskList()
        try! realm.write{
            for index in 0..<list.count{
                let newTask = Task()
                newTask.item = list[index]
                newTask.done = done[index]
                realm.add(newTask)
                newList.list.append(newTask)
                realm.add(newList)
            }
        }
        print(realm.objects(TaskList.self))
        print("saved")
    }
    
}
