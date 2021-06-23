
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
    
//MARK: - Setting Cell editing and deletion
//    private func deleteCell(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .destructive, title: "Delete") {(_, _, _) in
//            self.listTable.beginUpdates()
//            Persistance.shared.delete(index: indexPath.row)
//            (self.taskList, self.doneList) = Persistance.shared.download()
//            self.listTable.deleteRows(at: [indexPath], with: .fade)
//            self.listTable.endUpdates()
//        }
//        return action
//    }
//    private func editCell(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .normal, title: "Edit") {(_, _, _) in
//            self.listTable.beginUpdates()
//            let alert = UIAlertController(title: "Edit current task", message: "Insert new text", preferredStyle: .alert)
//            alert.addTextField()
//            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {_ in
//                let tf = alert.textFields?.first
//                if let newText = tf?.text {
//                    Persistance.shared.edit(index: indexPath.row, text: newText)
//                }
//            }))
//            self.present(alert, animated: true)
//            self.listTable.reloadData()
//            self.listTable.endUpdates()
//        }
//        return action
//    }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let edit = editCell(rowIndexPathAt: indexPath)
//        let delete = deleteCell(rowIndexPathAt: indexPath)
//        let swipe = UISwipeActionsConfiguration(actions: [edit, delete])
//        return swipe
//    }
//MARK: - swift 4+ ??
//    func tableView(_ tableView: UITableView,
//                    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//     {
//         let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//                 success(true)
//             })
//    editAction.backgroundColor = .blue
//             return UISwipeActionsConfiguration(actions: [editAction])
//     }
//     func tableView(_ tableView: UITableView,
//                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//     {
//         let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//             success(true)
//         })
//         deleteAction.backgroundColor = .red
//         return UISwipeActionsConfiguration(actions: [deleteAction])
//     }
    
//MARK: - Almost
//    func tableView(_ tableView: UITableView,
//                   commit editingStyle: UITableViewCell.EditingStyle,
//                     forRowAt indexPath: IndexPath){
//        if editingStyle == .insert{
//        tableView.beginUpdates()
//        let alert = UIAlertController(title: "Edit task", message: "Type new text", preferredStyle: .alert)
//        alert.addTextField()
//        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {_ in
//            let tf = alert.textFields?.first
//            if let newText = tf?.text {
//                Persistance.shared.edit(index: indexPath.row, text: newText)
//                (self.taskList, self.doneList) = Persistance.shared.download()
//                tableView.reloadData()
//            }
//        }))
//        self.present(alert, animated: true)
//        tableView.endUpdates()
//        }
//        if editingStyle == .delete{
//            tableView.beginUpdates()
//            Persistance.shared.delete(index: indexPath.row)
//            (taskList, doneList) = Persistance.shared.download()
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.endUpdates()
//        }
//    }
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
