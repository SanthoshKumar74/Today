//
//  Remainder .swift
//  Today
//
//  Created by Santhosh on 23/02/22.
//

import Foundation

// Remainder Struct Contains the Data Source which is used to populate the Table Views.
struct Reminder{
    var id: String
    var title: String
    var date: Date
    var notes:String? = nil
    var isComplete: Bool = false
}

extension Reminder{
    static var testData = [Reminder(id: UUID().uuidString, title: "Read UIKit", date: Date().addingTimeInterval(300), notes: nil, isComplete: false),
                    Reminder(id: UUID().uuidString, title: "Prepare for Meeting", date: Date().addingTimeInterval(400), notes: nil, isComplete: false),
                    Reminder(id: UUID().uuidString, title: "Migrate the Branches", date: Date().addingTimeInterval(600), notes: nil, isComplete: true),
                    Reminder(id: UUID().uuidString, title: "Finish Previous Tasks", date: Date().addingTimeInterval(800), notes: nil, isComplete: false),
                    Reminder(id: UUID().uuidString, title: "Read SwiftUI", date: Date().addingTimeInterval(450), notes: nil, isComplete: false),
                    Reminder(id: UUID().uuidString, title: "30min Workout", date: Date().addingTimeInterval(350), notes: nil, isComplete: false),
                    Reminder(id: UUID().uuidString, title: "Read Books", date: Date().addingTimeInterval(100), notes: nil, isComplete: true),
                    Reminder(id: UUID().uuidString, title: "Go for a walk", date: Date().addingTimeInterval(250), notes: nil, isComplete: false)]
}
