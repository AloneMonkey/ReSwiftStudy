//
//  ToDoListReducer.swift
//  ReSwiftToDoList
//
//  Created by monkey on 2017/4/20.
//  Copyright © 2017年 Coder. All rights reserved.
//

import Foundation
import ReSwift

class ToDoListReducer : ReSwift.Reducer{
    
    init() { }
    
    func handleAction(action: Action, state: ToDoListState?) -> ToDoListState {
        guard var state = state else {
            return ToDoListState()
        }
        
        var toDoList = state.toDoList
        
        toDoList = passActionToList(action, toDoList: toDoList)
        toDoList = passActionToItems(action, toDoList: toDoList)
        
        state.toDoList = toDoList
        
        return state
    }
    
    func passActionToList(_ action: Action, toDoList: ToDoList) -> ToDoList {
        
        guard let action = action as? ToDoListAction else { return toDoList }
        
        return action.apply(oldToDoList: toDoList)
    }
    
    func passActionToItems(_ action: Action, toDoList: ToDoList) -> ToDoList {
        
        var toDoList = toDoList
        
        toDoList.items = toDoList.items.flatMap{
            guard let action = action as? ToDoAction
                else { return $0 }
            return handleToDoAction(action, toDo: $0)
        }
        
        return toDoList
    }
    
    func handleToDoAction(_ action: ToDoAction, toDo: ToDo) -> ToDo {
        
        var toDo = toDo
        
        switch action {
        case let .check(toDoID):
            guard toDo.toDoID == toDoID else { return toDo }
            toDo.completion = .finished(when: Date())
            
        case let .uncheck(toDoID):
            guard toDo.toDoID == toDoID else { return toDo }
            toDo.completion = .unfinished
            
        case let .rename(toDoID, title: title):
            guard toDo.toDoID == toDoID else { return toDo }
            toDo.title = title
        }
        
        return toDo
    }
}
