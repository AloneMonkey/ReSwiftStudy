//
//  ToDoListState.swift
//  ReSwiftToDoList
//
//  Created by monkey on 2017/4/20.
//  Copyright © 2017年 Coder. All rights reserved.
//

import Foundation
import ReSwift

struct ToDoListState : StateType{
    var toDoList : ToDoList = ToDoList.demoList()
    var selection: SelectionState = nil
}
