//
//  swiftDataLearnApp.swift
//  swiftDataLearn
//
//  Created by Qaim's Macbook  on 23/04/2025.
//

import SwiftUI
import SwiftData

@main
struct swiftDataLearnApp: App {
    var body: some Scene {
        WindowGroup {
            PersonListView()
        }
        .modelContainer(for: Person.self)
    }
}
