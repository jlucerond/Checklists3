//
//  ChecklistItem.swift
//  Checklists3
//
//  Created by Joe Lucero on 12/6/16.
//  Copyright © 2016 Joe Lucero. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked () {
        checked = !checked
    }
}
