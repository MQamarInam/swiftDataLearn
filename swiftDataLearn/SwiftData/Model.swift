//
//  Destination.swift
//  swiftDataLearn
//
//  Created by Qaim's Macbook  on 23/04/2025.
//

import Foundation
import SwiftData

@Model
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
