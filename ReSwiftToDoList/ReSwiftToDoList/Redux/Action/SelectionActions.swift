//
//  SelectionActions.swift
//  ReSwiftToDoList
//
//  Created by monkey on 2017/4/20.
//  Copyright © 2017年 Coder. All rights reserved.
//

import Foundation
import ReSwift

enum SelectionAction: ReSwift.Action {
    
    case deselect
    case select(row: Int)
    
    var selectionState: SelectionState {
        switch self {
            case .deselect: return nil
            case .select(row: let row): return row
        }
    }
}
