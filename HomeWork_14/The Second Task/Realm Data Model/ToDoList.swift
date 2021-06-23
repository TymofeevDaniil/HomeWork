
import Foundation
import RealmSwift

class Persistance{
    static let shared = Persistance()
    private let realm = try! Realm()
    
    func download() -> ([String], [Bool]){
        var textList = [String]()
        var doneList = [Bool]()
        let savedList = realm.objects(Task.self)
        guard let _ = savedList.first else {return ([], [])}
        for index in 0..<savedList.count{
            textList.append(savedList[index].item)
            doneList.append(savedList[index].done)
        }
        print("loaded")
        return (textList, doneList)
    }
    func add(text: String, done: Bool){
        try! realm.write{
            let newTask = Task()
            newTask.item = text
            newTask.done = done
            realm.add(newTask)
        }
        print("saved")
    }
    func complete(index: Int, done: Bool){
        let allTasks = realm.objects(Task.self)
        try! realm.write{
            allTasks[index].done = done
        }
        print("saved")
    }
    func edit(index: Int, text: String){
        let allTasks = realm.objects(Task.self)
        try! realm.write{
            allTasks[index].item = text
        }
        print("saved")
    }
    func delete(index: Int){
        let allTasks = realm.objects(Task.self)
        try! realm.write{
            realm.delete(allTasks[index])
        }
        print("deleted")
    }
}
