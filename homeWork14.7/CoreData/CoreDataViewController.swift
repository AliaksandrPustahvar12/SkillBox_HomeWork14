//
//  CoreDataViewController.swift
//  homeWork14.7
//
//  Created by Aliaksandr Pustahvar on 11.12.22.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {
    
    @IBOutlet var coreDataTableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notes: [Note] = []
    
    static let dateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .short
        return dateformatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addNewNote))
        coreDataTableView.dataSource = self
        coreDataTableView.delegate = self
        updateNotes()
    }
    @objc func addNewNote() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "addNewNote") as? CoreDataAddingViewController else { return }
        vc.title = "New note"
        vc.addNotesUpdate = {[weak self] in
            self?.updateNotes()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    func updateNotes() {
        do {
            self.notes = try context.fetch(Note.fetchRequest())
            DispatchQueue.main.async {
                self.coreDataTableView.reloadData()
            }
        } catch {}
    }
}
extension CoreDataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CDCell") as? CoreDataTableViewCell else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "identifier")
            return cell
        }
        let note = notes[indexPath.row]
        let stringDate = Self.dateFormatter.string(from: note.date!)
        cell.nameLabel.text = note.name
        cell.dateLabel.text = stringDate
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            let noteToDelete = self.notes[indexPath.row]
            self.context.delete(noteToDelete)
            do {
                try self.context.save()
            } catch {}
            self.updateNotes()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
