//
//  ToDoList.swift
//  ReSwiftToDoList
//
//  Created by monkey on 2017/4/20.
//  Copyright © 2017年 Coder. All rights reserved.
//

import Foundation

struct ToDoList {
    static var empty: ToDoList { return ToDoList(items: []) }
    
    var items : [ToDo]
    
    var isEmpty: Bool {
        return items.isEmpty
    }
    
    mutating func appendItem(_ toDo: ToDo) {
        
        items.append(toDo)
    }
    
    mutating func insertItem(_ toDo: ToDo, atIndex index: Int) {
        
        if index < 1 {
            items.insert(toDo, at: 0)
        } else if index < items.count {
            items.insert(toDo, at: index)
        } else {
            items.append(toDo)
        }
    }
    
    func indexOf(toDoID: ToDoID) -> Int? {
        
        return items.index(where: { $0.toDoID == toDoID })
    }
    
    func toDo(toDoID: ToDoID) -> ToDo? {
        
        guard let index = indexOf(toDoID: toDoID)
            else { return nil }
        
        return items[index]
    }
    
    mutating func removeItem(toDoID: ToDoID) {
        
        guard let index = indexOf(toDoID: toDoID)
            else { return }
        
        items.remove(at: index)
    }
}

extension ToDoList {
    
    init() {
        self.items = []
    }
    
    static func demoList() -> ToDoList {
        
        let toDos = [
            ToDo(title: "create a new list", completion: .finished(when: nil)),
            ToDo(title: "rename the list", completion: .unfinished),
            ToDo(title: "get productive", completion: .unfinished)
        ]
        
        return ToDoList(items: toDos)
    }
}

extension ToDoList: Equatable {
    
    /// Equality check ignoring the `items`'s `ToDoID`s.
    func hasEqualContent(_ other: ToDoList) -> Bool {
        
        guard items.count == other.items.count else { return false }
        
        for toDo in items {
            
            guard other.items.contains(where: { $0.hasEqualContent(toDo) }) else {
                return false
            }
        }
        
        for toDo in other.items {
            
            guard items.contains(where: { $0.hasEqualContent(toDo) }) else {
                return false
            }
        }
        
        return true
    }
}

func ==(lhs: ToDoList, rhs: ToDoList) -> Bool {
    
    return lhs.items == rhs.items
}
