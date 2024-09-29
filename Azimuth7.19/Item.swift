//
//  Item.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
