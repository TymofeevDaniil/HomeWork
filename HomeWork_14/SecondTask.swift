
import UIKit

class SecondTask: UIViewController {
    
    @IBOutlet weak var listTable: UITableView!
    @IBAction func addButton(_ sender: Any) {
        let window = AddTaskWindow.loadFromNIB()
        window.center = self.view.center
        window.delegate = self
        self.view.addSubview(window)
    }
    var taskList: [String] = ["Люби", "Корми", "Никогда не бросай"]
    var newTask = [String]()
    var savedTask = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskList = Persistance.shared.load()
        listTable.reloadData()
        print(savedTask)
    }
    override func viewDidDisappear(_ animated: Bool) {
        savedTask = [String]()
        savedTask += taskList + newTask
        Persistance.shared.save(list: savedTask)
        print(savedTask)
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
        return cell
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                     forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            tableView.beginUpdates()
            taskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

//MARK: - New task window delegation
extension SecondTask: NewTask{
    func add(window: AddTaskWindow) {
        guard let text = window.taskTextField.text else {return}
        newTask.append(text)
        window.removeFromSuperview()
        let newIndexPath = IndexPath(row: taskList.count, section: 0)
        taskList += newTask
        listTable.insertRows(at: [newIndexPath], with: .fade)
        self.view.layoutSubviews()
    }
}
