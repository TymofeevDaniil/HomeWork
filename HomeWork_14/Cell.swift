
import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var taskText: UILabel!
    @IBOutlet weak var taskSwitch: UISwitch!
    
    func load(){
        taskSwitch.isOn = false
    }
}
