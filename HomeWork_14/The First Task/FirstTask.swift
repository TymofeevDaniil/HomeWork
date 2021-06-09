
import UIKit

class FirstTask: UIViewController {
    
    var savedName = ""
    var savedSurname = ""
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBAction func naming(_ sender: Any) {
        guard let text = nameTextField.text else {return}
        savedName = text
        SavedUserData.shared.savedName = self.savedName
    }
    @IBAction func surnaming(_ sender: Any) {
        guard let text = surnameTextField.text else {return}
        savedSurname = text
        SavedUserData.shared.savedSurname = self.savedSurname
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.placeholder = SavedUserData.shared.savedName
        surnameTextField.placeholder = SavedUserData.shared.savedSurname
    }
}

