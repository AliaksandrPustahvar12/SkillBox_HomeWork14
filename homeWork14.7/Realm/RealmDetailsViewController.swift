//
//  RealmDetailsViewController.swift
//  homeWork14.7
//
//  Created by Aliaksandr Pustahvar on 4.12.22.
//

import UIKit

class RealmDetailsViewController: UIViewController {
    
    public var item: ToDoItem?
    public var deleteUpd: (() -> Void)?

    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    static let dateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .short
        return dateformatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        itemLabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButton))
    }
    @objc private func deleteButton() {
        guard let itemToDelete = self.item else {
            return }
        PersistanceR.shared.deleteItem(item: itemToDelete)
        deleteUpd?()
        navigationController?.popViewController(animated: true)
    }
}
