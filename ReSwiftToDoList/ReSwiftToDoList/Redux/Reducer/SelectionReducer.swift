//
//  SelectionReducer.swift
//  ReSwiftToDoList
//
//  Created by monkey on 2017/4/20.
//  Copyright © 2017年 Coder. All rights reserved.
//

import Foundation
import ReSwift

class SelectionReducer {
    
    init() { }
    
    func handleAction(_ action: Action, state: SelectionState) -> SelectionState {
        
        guard let action = action as? SelectionAction else { return state }
        
        switch action {
            case .deselect: return nil
            case .select(row: let row): return row
        }
    }
}
