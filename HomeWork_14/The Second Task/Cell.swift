
import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var taskText: UILabel!
    @IBOutlet weak var taskSwitch: UISwitch!
    @IBAction func completion(_ sender: Any) {
        Persistance.shared.complete(index: getIndex(), done: taskSwitch.isOn)
    }
//MARK: - Get an index of the current Cell
    func getIndex() -> Int{
        let superView = self.superview as! UITableView
        let indexPath = superView.indexPath(for: self)!
        return indexPath[1]
    }
}
