//
//  ChecklistViewController.swift
//  Checklists3
//
//  Created by Joe Lucero on 11/9/16.
//  Copyright © 2016 Joe Lucero. All rights reserved.
//

// The Add Item Screen: this branch goes pages 70-109

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items : [ChecklistItem]
    
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        
        let row0item = ChecklistItem()
        row0item.text = "workout"
        row0item.checked = false
        items.append(row0item)
        
        let row1item = ChecklistItem()
        row1item.text = "tutor"
        row1item.checked = true
        items.append(row1item)
        
        let row2item = ChecklistItem()
        row2item.text = "cook"
        row2item.checked = false
        items.append(row2item)
        
        let row3item = ChecklistItem()
        row3item.text = "volleyball"
        row3item.checked = false
        items.append(row3item)
        
        let row4item = ChecklistItem()
        row4item.text = "code"
        row4item.checked = true
        items.append(row4item)
        
        let row5item = ChecklistItem()
        row5item.text = "grab drinks"
        row5item.checked = false
        items.append(row5item)
        
        let row6item = ChecklistItem()
        row6item.text = "finish up app"
        row6item.checked = false
        items.append(row6item)
        
        super.init(coder: aDecoder)
    }
    
    //AddItemViewControllerDelegate Protocols
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemViewController,
                               didFinishAdding item: ChecklistItem) {
        
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }

    
    // Other Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem",
                                                 for: indexPath)
        
        let item = items[indexPath.row]
        
        configureCheckmark(for: cell, with: item)
        configureText(for: cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destination as! UINavigationController
            
            let controller = navigationController.topViewController as! AddItemViewController
            
            controller.delegate = self
        }
    }

    func configureCheckmark(for cell: UITableViewCell,
                            with item: ChecklistItem) {
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func configureText(for cell: UITableViewCell,
                       with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
}

