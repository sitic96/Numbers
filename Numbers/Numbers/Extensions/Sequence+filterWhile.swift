//
//  Sequence+filterWhile.swift
//  Numbers
//
//  Created by Sitora Guliamova on 4/10/24.
//

import Foundation

extension Sequence {
    func filterWhile(condition: (Element) -> Bool, stopWhen: (Element) -> Bool) -> [Element] {
        var result = [Element]()
        
        for item in self {
            if condition(item) {
                result.append(item)
            }
            
            if stopWhen(item) {
                break
            }
        }
        
        return result
    }
}
