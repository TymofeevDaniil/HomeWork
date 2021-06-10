
import UIKit

class FirstTask: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBAction func naming(_ sender: Any) {
        guard let text = nameTextField.text else {return}
        SavedUserData.shared.savedName = text
    }
    @IBAction func surnaming(_ sender: Any) {
        guard let text = surnameTextField.text else {return}
        SavedUserData.shared.savedSurname = text
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.placeholder = SavedUserData.shared.savedName
        surnameTextField.placeholder = SavedUserData.shared.savedSurname
    }
}

