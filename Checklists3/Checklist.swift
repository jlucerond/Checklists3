//
//  Checklist.swift
//  Checklists3
//
//  Created by Joe Lucero on 12/19/16.
//  Copyright © 2016 Joe Lucero. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    var name = ""
    var items = [ChecklistItem]()

    init(name: String) {
        self.name = name
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
    }
    
}