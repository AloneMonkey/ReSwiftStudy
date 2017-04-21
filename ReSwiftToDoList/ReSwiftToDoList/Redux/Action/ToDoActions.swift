//
//  ToDoActions.swift
//  ReSwiftToDoList
//
//  Created by monkey on 2017/4/20.
//  Copyright © 2017年 Coder. All rights reserved.
//

import Foundation
import ReSwift

enum ToDoAction : ReSwift.Action{
    
    case check(ToDoID)
    case uncheck(ToDoID)
    
    case rename(ToDoID, title: String)
    
    // MARK: Undoable
    
    var isUndoable: Bool { return true }
    
    var name: String {
        switch self {
        case .check: return "Finish Task"
        case .uncheck: return "Mark as Unfinished"
        case .rename: return "Rename Task"
        }
    }
}
