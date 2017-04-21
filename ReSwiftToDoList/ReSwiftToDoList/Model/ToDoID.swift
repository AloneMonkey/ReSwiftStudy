//
//  ToDoID.swift
//  ReSwiftToDoList
//
//  Created by monkey on 2017/4/20.
//  Copyright © 2017年 Coder. All rights reserved.
//

import Foundation

struct ToDoID {
    
    let identifier: String
    
    init() {
        
        self.identifier = UUID().uuidString
    }
    
    init(UUID: Foundation.UUID) {
        
        self.identifier = UUID.uuidString
    }
    
    init?(identifier: String) {
        
        guard let UUID = UUID(uuidString: identifier) else {
            return nil
        }
        
        self.identifier = UUID.uuidString
    }
}

extension ToDoID: Equatable { }

func ==(lhs: ToDoID, rhs: ToDoID) -> Bool {
    
    return lhs.identifier == rhs.identifier
}

extension ToDoID: Hashable {
    
    var hashValue: Int { return 189 &* identifier.hashValue }
}

extension ToDoID: CustomStringConvertible {
    
    var description: String { return identifier }
}
