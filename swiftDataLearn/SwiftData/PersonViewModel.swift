//
//  PersonViewModel.swift
//  swiftDataLearn
//
//  Created by Qaim's Macbook  on 11/09/2025.
//

import Foundation
import SwiftUI
import SwiftData

class PersonViewModel: ObservableObject {
    
    @Published var persons: [Person] = []
    
    func fetchData(context: ModelContext) {
        do {
            let descriptor = FetchDescriptor<Person>()
            persons = try context.fetch(descriptor)
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func addPerson(name: String, age: Int, context: ModelContext) {
        let newPerson = Person(name: name, age: age)
        context.insert(newPerson)
        try? context.save()
        fetchData(context: context)
    }
    
    func deletePerson(person: Person, context: ModelContext) {
        context.delete(person)
        try? context.save()
        fetchData(context: context)
    }
    
    func updatePerson(person: Person, name: String, age: Int, context: ModelContext) {
        person.name = name
        person.age = age
        try? context.save()
        fetchData(context: context)
    }
    
}
