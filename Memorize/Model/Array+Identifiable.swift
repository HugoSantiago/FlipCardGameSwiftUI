//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Hugo Santiago on 20/08/20.
//  Copyright © 2020 Hugo Santiago. All rights reserved.
//

import Foundation

extension Array where Element:Identifiable {
    
    func firstIndex (matching: Element) -> Int{
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return -1
    }
}
