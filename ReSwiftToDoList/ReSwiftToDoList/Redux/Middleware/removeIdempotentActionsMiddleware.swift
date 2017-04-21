//
//  removeIdempotentActionsMiddleware.swift
//  ReSwiftToDoList
//
//  Created by monkey on 2017/4/20.
//  Copyright © 2017年 Coder. All rights reserved.
//

import Foundation
import ReSwift

let removeIdempotentActionsMiddleware: Middleware = { dispatch, getState in
    return { next in
        return { action in
            
            guard let state = getState() as? ToDoListState
                else { return next(action) }
            
            if case let ToDoAction.rename(toDoID, title: title) = action,
                let toDo = state.toDoList.toDo(toDoID: toDoID),
                toDo.title == title {
                
                print("Ignoring \(action)")
                
                return state
            } else if let action = action as? SelectionAction,
                action.selectionState == state.selection {
                
                print("Ignoring \(action)")
                
                return state
            }
            
            return next(action)
        }
    }
}
