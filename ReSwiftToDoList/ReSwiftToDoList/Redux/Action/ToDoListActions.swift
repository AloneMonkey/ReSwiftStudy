//
//  ToDoListActions.swift
//  ReSwiftToDoList
//
//  Created by monkey on 2017/4/20.
//  Copyright © 2017年 Coder. All rights reserved.
//

import Foundation
import ReSwift

protocol ToDoListAction: ReSwift.Action {
    
    func apply(oldToDoList: ToDoList) -> ToDoList
}

struct ReplaceToDoListAction: ToDoListAction {
    
    let newToDoList: ToDoList
    
    func apply(oldToDoList: ToDoList) -> ToDoList {
        
        return newToDoList
    }
}

struct InsertTaskAction: ToDoListAction {
    
    let toDo: ToDo
    let index: Int
    
    func apply(oldToDoList: ToDoList) -> ToDoList {
        var result = oldToDoList
        result.insertItem(toDo, atIndex: index)
        return result
    }
}

struct AddTaskAction: ToDoListAction {
    
    let toDo: ToDo
    
    func apply(oldToDoList: ToDoList) -> ToDoList {
        var result = oldToDoList
        result.appendItem(toDo)
        return result
    }
}

struct RemoveTaskAction: ToDoListAction {
    
    let toDoID: ToDoID
    
    func apply(oldToDoList: ToDoList) -> ToDoList {
        
        var result = oldToDoList
        result.removeItem(toDoID: toDoID)
        return result
    }
    
    var isUndoable: Bool { return true }
    var name: String { return "Remove Task" }
}
