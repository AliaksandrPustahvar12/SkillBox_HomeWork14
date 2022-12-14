//
//  RealmAddingViewController.swift
//  homeWork14.7
//
//  Created by Aliaksandr Pustahvar on 2.12.22.
//

import UIKit

class RealmAddingViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textToAdd: UITextField!
    @IBOutlet var dateToAdd: UIDatePicker!
    public var addUpdate: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textToAdd.becomeFirstResponder()
        textToAdd.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButton))
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func saveButton() {
        if let text = textToAdd.text, !text.isEmpty {
            let date = dateToAdd.date
            PersistanceR.shared.addItem(name: text, date: date)
            addUpdate?()
            navigationController?.popViewController(animated: true)
        }
    }
}
