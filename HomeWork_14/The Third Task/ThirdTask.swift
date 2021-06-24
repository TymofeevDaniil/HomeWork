
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
        coreTable.delegate = self
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
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit"){ (action, view, success) in
            self.coreTable.beginUpdates()
            let alert = UIAlertController(title: "Edit task", message: "Type new text", preferredStyle: .alert)
            alert.addTextField()
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {_ in
                let tf = alert.textFields?.first
                if let newText = tf?.text {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    let fetchRequest: NSFetchRequest<TaskCore> = TaskCore.fetchRequest()
                    do {
                        let tasks = try context.fetch(fetchRequest)
                        tasks[indexPath.row].text = newText
                        try context.save()
                    } catch let error as NSError {
                        print(error)
                    }
                }
                self.coreTable.reloadData()
            }))
            self.present(alert, animated: true)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<TaskCore> = TaskCore.fetchRequest()
            do {
                self.task = try context.fetch(fetchRequest)
            } catch let error as NSError {
                print(error)
            }
            self.coreTable.reloadData()
            self.coreTable.endUpdates()
        }
        return UISwipeActionsConfiguration(actions: [editAction])
     }
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, success) in
            self.coreTable.beginUpdates()
            
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
            self.coreTable.deleteRows(at: [indexPath], with: .fade)
            self.coreTable.reloadData()
            self.coreTable.endUpdates()
            print("deleting")
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
     }
}
