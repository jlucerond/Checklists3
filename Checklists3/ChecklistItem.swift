//
//  ChecklistItem.swift
//  Checklists3
//
//  Created by Joe Lucero on 12/6/16.
//  Copyright © 2016 Joe Lucero. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    
    func toggleChecked () {
        checked = !checked
    }
    
    // NSCoding Protocols
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    init(textForItem: String, checked: Bool) {
        self.text = textForItem
        self.checked = checked
        super.init()
    }
    
    convenience init(textForItem: String) {
        self.init(textForItem: textForItem, checked: false)
    }
}
