//
//  Item.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI
import SwiftData

@Model
final class Objective {
    var id: String = UUID().uuidString
    var title: String
    var remark: String
    var timestamp: Date
    var dateStarted: Date
    var dateCompleted: Date
    var defineObstacle: String
    var priority: Int?
    var status: Status.RawValue
    @Relationship(deleteRule: .cascade)
    var notes: [Note]?
    @Relationship(inverse: \Tag.objectives)
    var tags: [Tag]?
    var allowsHitTesting: Bool = false
    
    init(
        title: String,
        remark: String,
        timestamp: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        defineObstacle: String = "",
        priority: Int? = nil,
        status: Status = .Pending
    ) {
        self.title = title
        self.remark = remark
        self.timestamp = timestamp
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.defineObstacle = defineObstacle
        self.priority = priority
        self.status = status.rawValue
    }
    var icon: Image {
        switch Status(rawValue: status)! {
        case .Pending:
            Image(systemName: "figure.hiking.circle")
        case .Hold:
            Image(systemName: "figure.mixed.cardio.circle")
        case .Complete:
            Image(systemName: "figure.golf.circle")
        case .Active:
            Image(systemName: "figure.wrestling.circle")
        case .Archived:
            Image(systemName: "figure.highintensity.intervaltraining.circle")
        case .Review:
            Image(systemName: "figure.martial.arts.circle")
        case .Pending_Approval :
            Image(systemName: "backpack.circle")
        case .Published:
            Image(systemName: "figure.run.circle")
        case .First_Draft:
            Image(systemName: "figure.open.water.swim.circle")
        case .Brainstorm:
            Image(systemName: "figure.yoga.circle")
        case .Design:
            Image(systemName: "figure.mind.and.body.circle")
        case .Final_Draft:
            Image(systemName: "book.circle")
        case .Planning:
            Image(systemName: "backpack.circle")
        case .Pending_Final_Review:
            Image(systemName: "book.closed.circle")
        }
    }
}
///TODO:  create custom icons for icon
enum Status: Int, Codable, Identifiable, CaseIterable  {
    case Pending, Hold, Complete, Active, Archived, Review, Pending_Approval, Pending_Final_Review, Published, First_Draft, Brainstorm, Design, Final_Draft, Planning
    var id: Self { self }
    var description: String {
        switch self{
        case .Pending: return "Pending"
        case .Hold: return "Hold"
        case .Complete: return "Complete"
        case .Active: return "Active"
        case .Archived: return "Archived"
        case .Review: return "Review"
        case .Pending_Approval: return "Pending Approval"
        case .Pending_Final_Review: return "Pending Final Review"
        case .Published: return "Published"
        case .First_Draft: return "First Draft"
        case .Brainstorm: return "Brainstorm"
        case .Design: return "Design"
        case .Final_Draft: return "Final Draft"
        case .Planning:return "Planning"
        }
    }
}
    
