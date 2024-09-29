//
//  Tag.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI
import SwiftData

@Model
class Tag {
    var name: String
    var color: String
    var objectives: [Objective]?
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
