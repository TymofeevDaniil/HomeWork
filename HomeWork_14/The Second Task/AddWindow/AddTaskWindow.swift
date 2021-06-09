//
//  AddTaskWindow.swift
//  HomeWork_14
//
//  Created by Danil Tymofeev on 25.05.2021.
//

import UIKit

protocol NewTask{
    func add(window: AddTaskWindow)
}
class AddTaskWindow: UIView{
    var delegate: NewTask?
    @IBOutlet weak var taskTextField: UITextField!
    @IBAction func addTask(_ sender: Any) {
        delegate?.add(window: self)
    }
    static func loadFromNIB() -> AddTaskWindow{
        let nib = UINib(nibName: "AddTaskWindow", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! AddTaskWindow
    }
}
