//
//  RealmViewController.swift
//  homeWork14.7
//
//  Created by Aliaksandr Pustahvar on 1.12.22.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController {
    var data = [ToDoItem]()
    private let realm = try! Realm()
    @IBOutlet var realmTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateItems()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addButton))
        realmTableView.delegate = self
        realmTableView.dataSource = self
    }
    @objc func addButton() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewItem") as? RealmAddingViewController else { return }
        vc.title = "New Item"
        vc.addUpdate = {[weak self] in
            self?.updateItems()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateItems() {
        data = realm.objects(ToDoItem.self).map({$0})
        DispatchQueue.main.async {
            self.realmTableView.reloadData()
        }
    }
}
extension RealmViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RealmCell") as? RealmTableViewCell else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "identifire")
            return cell
        }
        cell.itemLabel.text = data[indexPath.row].item
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Details") as? RealmDetailsViewController else { return }
        vc.item = item
        vc.title = item.item
        vc.deleteUpd = { [weak self] in
            self?.updateItems()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
