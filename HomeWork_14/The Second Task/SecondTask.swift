
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
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                     forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            tableView.beginUpdates()
            Persistance.shared.delete(index: indexPath.row)
            (taskList, doneList) = Persistance.shared.download()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
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
