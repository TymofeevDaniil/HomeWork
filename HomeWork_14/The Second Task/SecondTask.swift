
import UIKit

class SecondTask: UIViewController {
    
    @IBOutlet weak var listTable: UITableView!
    @IBAction func addButton(_ sender: Any) {
        let window = AddTaskWindow.loadFromNIB()
        window.center = self.view.center
        window.delegate = self
        self.view.addSubview(window)
    }
    var taskList = [String]()
    var doneList = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTable.delegate = self
        
        (taskList, doneList) = Persistance.shared.download()
        listTable.reloadData()
    }
}
//MARK: - Setting Table View
extension SecondTask: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension SecondTask: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.taskText.text = taskList[indexPath.row]
        cell.taskSwitch.isOn = doneList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit"){ (action, view, success) in
            self.listTable.beginUpdates()
            let alert = UIAlertController(title: "Edit task", message: "Type new text", preferredStyle: .alert)
            alert.addTextField()
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {_ in
                let tf = alert.textFields?.first
                if let newText = tf?.text {
                    Persistance.shared.edit(index: indexPath.row, text: newText)
                    (self.taskList, self.doneList) = Persistance.shared.download()
                    self.listTable.reloadData()
                }
            }))
            self.present(alert, animated: true)
            self.listTable.endUpdates()
        }
        return UISwipeActionsConfiguration(actions: [editAction])
     }
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, success) in
            self.listTable.beginUpdates()
            Persistance.shared.delete(index: indexPath.row)
            (self.taskList, self.doneList) = Persistance.shared.download()
            self.listTable.deleteRows(at: [indexPath], with: .fade)
            self.listTable.endUpdates()
            print("deleting")
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
     }
}

//MARK: - New task window delegation
extension SecondTask: NewTask{
    func add(window: AddTaskWindow) {
        guard let text = window.taskTextField.text else {return}
        Persistance.shared.add(text: text, done: false)
        (taskList, doneList) = Persistance.shared.download()
        listTable.reloadData()
        window.removeFromSuperview()
        self.view.layoutSubviews()
    }
}
