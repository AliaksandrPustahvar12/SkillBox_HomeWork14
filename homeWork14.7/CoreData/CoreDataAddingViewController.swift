//
//  CoreDataAddingViewController.swift
//  homeWork14.7
//
//  Created by Aliaksandr Pustahvar on 11.12.22.
//

import UIKit
import CoreData

class CoreDataAddingViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var noteNameTF: UITextField!
    @IBOutlet var noteDate: UIDatePicker!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    public var addNotesUpdate: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteNameTF.becomeFirstResponder()
        noteNameTF.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNoteButton))
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func saveNoteButton() {
        if let text = noteNameTF.text, !text.isEmpty {
            let date = noteDate.date
            let newNote = Note(context: self.context)
            newNote.name = text
            newNote.date = date
            do {
                try self.context.save()
            } catch {}
        }
        addNotesUpdate?()
        navigationController?.popViewController(animated: true)
    }
}
