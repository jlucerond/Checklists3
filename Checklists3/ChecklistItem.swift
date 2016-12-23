//
//  ChecklistItem.swift
//  Checklists3
//
//  Created by Joe Lucero on 12/6/16.
//  Copyright © 2016 Joe Lucero. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    
    // MARK: - Variables

    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    
    func toggleChecked () {
        checked = !checked
    }
    
    // MARK: - NSCoding Protocols
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
        aCoder.encode(dueDate, forKey: "DueDate")
        aCoder.encode(shouldRemind, forKey: "ShouldRemind")
        aCoder.encode(itemID, forKey: "ItemID")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
        itemID = aDecoder.decodeInteger(forKey: "ItemID")
        super.init()
    }
    
    // MARK: - Initializers
    override init() {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    init(textForItem: String, checked: Bool) {
        self.text = textForItem
        self.checked = checked
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    convenience init(textForItem: String) {
        self.init(textForItem: textForItem, checked: false)
    }
}
