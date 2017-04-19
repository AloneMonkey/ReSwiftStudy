//
//  CounterReducer.swift
//  ReSwiftCounter
//
//  Created by monkey on 2017/4/19.
//  Copyright © 2017年 Coder. All rights reserved.
//

import Foundation
import ReSwift

struct CounterReducer : Reducer {
    typealias ReducerStateType = AppState
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        var state = state ?? AppState()
        
        switch action {
        case _ as CounterActionIncrease:
            state.counter += 1
        case _ as CounterActionDecrease:
            state.counter -= 1
        default:
            break
        }
        
        return state
    }
}
