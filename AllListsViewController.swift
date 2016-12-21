//
//  AllListsViewController.swift
//  Checklists3
//
//  Created by Joe Lucero on 12/19/16.
//  Copyright © 2016 Joe Lucero. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Variables
    var dataModel: DataModel!
    
    // MARK: - View Controller Methods
    
    override func viewDidLoad() {
        print("1 View Did Load")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("2 View Did Appear")
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self

        let index = dataModel.indexOfSelectedChecklist
        print("Index is: \(index)")
        if  index != -1 && index < dataModel.lists.count {
            let checklist = dataModel.lists[index]
            performSegue(withIdentifier: "ShowChecklist", sender: checklist)
            print("3 Will perform a segue since I'm loading an old checklist")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source & delegate methods
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(for: tableView)
        
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        
        // input new function here w/ 1 parameter- checklist
        cell.detailTextLabel!.text = titleForDetailTextLabel(checklist)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        print("Changing the ChecklistIndex to indexPath#\(indexPath)")
        dataModel.indexOfSelectedChecklist = indexPath.row
        
        let checklist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView,
                            accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let navigationController = storyboard!.instantiateViewController(withIdentifier: "ListDetailNavigationController") as! UINavigationController
        let controller = navigationController.topViewController as! ListDetailViewController
        
        controller.delegate = self
        controller.checklistToEdit = dataModel.lists[indexPath.row]
        
        present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - ListDetailViewControllerDelegate Protocol
    
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController,
                                  didFinishAdding checklist: Checklist){
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController,
                                  didFinishEditing checklist: Checklist){
        if let index = dataModel.lists.index(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                cell.textLabel!.text = checklist.name
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UINavigationControllerDelegate Protocol
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        print("4 navigationController willShow animated")
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1
            print("Changing the ChecklistIndex back to -1")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist"{
            let controller = segue.destination as! ChecklistViewController
            controller.checklist = sender as! Checklist
        } else if segue.identifier == "AddChecklist" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            controller.checklistToEdit = nil
            controller.delegate = self
        }
    }
 
    // MARK: - Helper Methods
    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifer = "Cell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer) {
            return cell
        } else {
            return UITableViewCell(style: .subtitle,
                                       reuseIdentifier: cellIdentifer)
        }
    }
    
    func titleForDetailTextLabel(_ checklist: Checklist) -> String {
        if checklist.items.count == 0 {
            return "(No Items)"
        } else if checklist.numberOfUncheckedItems == 0 {
            return "All done!"
        } else {
            return "\(checklist.numberOfUncheckedItems) Remaining"
        }
    }
    
}
