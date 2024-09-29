//
//  HapticManager.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}

