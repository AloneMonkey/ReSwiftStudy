//
//  ToDoListStore.swift
//  ReSwiftToDoList
//
//  Created by monkey on 2017/4/20.
//  Copyright © 2017年 Coder. All rights reserved.
//

import Foundation
import ReSwift

typealias ToDoListStore = Store<ToDoListState>

func getStore(defaultState:ToDoListState) -> ToDoListStore{
    return ToDoListStore(
        reducer : ToDoListReducer(),
        state : defaultState,
        middleware : [
            removeIdempotentActionsMiddleware,
            loggingMiddleware
        ]
    )
}
