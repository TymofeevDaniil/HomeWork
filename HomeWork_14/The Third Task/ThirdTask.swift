
import UIKit
import CoreData

class ThirdTask: UIViewController {
    
    var task: [TaskCore] = []
    @IBOutlet weak var coreTable: UITableView!
    
//MARK: - AddWindow creation (AlertController)
    @IBAction func coreAddTask(_ sender: Any) {
        let alertController = UIAlertController(title: "New Task", message: "Write text for a task", preferredStyle: .alert)
        let save = UIAlertAction(title: "Save", style: .default){ action in
            let tf = alertController.textFields?.first
            if let newTask = tf?.text {
                self.addTaskCore(text: newTask, done: false)
                self.coreTable.reloadData()
            }
        }
        alertController.addTextField()
        alertController.addAction(save)
        present(alertController, animated: true, completion: nil)
    }
    
//MARK: - Loading data from CoreData
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TaskCore> = TaskCore.fetchRequest()
        do {
            task = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: - Saving data into CoreData
    func addTaskCore (text: String, done: Bool){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "TaskCore", in: context) else {return}
        let taskObject = TaskCore(entity: entity, insertInto: context)
        taskObject.text = text
        taskObject.done = done
        do{
            try context.save()
            task.append(taskObject)
        } catch let error as NSError {
            print(error)
        }
    }
}

//MARK: - TableView settings
extension ThirdTask: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension ThirdTask: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        task.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCore") as! CellCore
        let task = task[indexPath.row]
        cell.coreLabel.text = task.text
        cell.coreSwitch.isOn = task.done
        return cell
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                     forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<TaskCore> = TaskCore.fetchRequest()
            if let tasks = try? context.fetch(fetchRequest){
                context.delete(tasks[indexPath.row])
                self.task.remove(at: indexPath.row)
            }
            do{
                try context.save()
            } catch let error as NSError {
                print(error)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            tableView.endUpdates()
        }
    }
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//
//  }
//
//  func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
//      return true
//  }
//
//  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
//  {
//      let update = UITableViewRowAction(style: .Normal, title: "Update") { action, index in
//          print("update")
//      }
//      let delete = UITableViewRowAction(style: .Default, title: "Delete") { action, index in
//          print("Delete")
//
//      }
//      return [delete, update]
//  }
}
