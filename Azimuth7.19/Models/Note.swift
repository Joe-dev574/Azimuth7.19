//
//  Note.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI
import SwiftData

@Model
class Note {
    init(colorString: String, noteTitle: String, content: String) {
        self.colorString = colorString
        self.noteTitle = noteTitle
        self.content = content
    }
    
    var id: String = UUID().uuidString
    var dateCreated: Date = Date()
    var colorString: String
    var noteTitle: String
    var content: String
    /// View Properties
    var allowsHitTesting: Bool = false
    
    var color: Color {
        Color(colorString)
    }
}
