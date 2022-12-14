//
//  UDViewController.swift
//  homeWork14.7
//
//  Created by Aliaksandr Pustahvar on 1.12.22.
//

import UIKit

class UDViewController: UIViewController {
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var surnameTF: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    @IBAction func saveInfo(_ sender: UIButton) {
        let nameToSave = nameTF.text
        PersistanceUD.shared.name = nameToSave
        let surnameToSave = surnameTF.text
        PersistanceUD.shared.surname = surnameToSave
        navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.text = PersistanceUD.shared.name
        surnameTF.text = PersistanceUD.shared.surname
        nameTF.becomeFirstResponder()
    }
}
