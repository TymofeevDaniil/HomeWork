
import UIKit
import CoreData
class CellCore: UITableViewCell {

    @IBOutlet weak var coreLabel: UILabel!
    @IBOutlet weak var coreSwitch: UISwitch!
    @IBAction func switching(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TaskCore> = TaskCore.fetchRequest()
        do {
            let tasks = try context.fetch(fetchRequest)
            tasks[getIndex()].done = coreSwitch.isOn
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
//MARK: - Get an index of the current Cell
    func getIndex() -> Int{
        let superView = self.superview as! UITableView
        let indexPath = superView.indexPath(for: self)!
        return indexPath[1]
    }
}
