//
//  IconPickerViewController.swift
//  Checklists3
//
//  Created by Joe Lucero on 12/22/16.
//  Copyright © 2016 Joe Lucero. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDelegate: class {
    func iconPicker(_ controller: IconPickerViewController,
                    didPick iconName: String)
}

class IconPickerViewController: UITableViewController {
    var delegate: IconPickerViewControllerDelegate?
    let icons = ["No Icon",
                 "Appointments",
                 "Birthdays",
                 "Chores",
                 "Drinks",
                 "Folder",
                 "Groceries",
                 "Inbox",
                 "Photos",
                 "Trips"]
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
        
        let iconName = icons[indexPath.row]
        cell.textLabel!.text = iconName
        cell.imageView!.image = UIImage(named: iconName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPick: iconName)
        }
    }
}
