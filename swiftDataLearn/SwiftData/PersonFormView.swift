//
//  EditPersonView.swift
//  swiftDataLearn
//
//  Created by Qaim's Macbook  on 27/04/2025.
//

import SwiftUI
import SwiftData

struct PersonFormView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @ObservedObject var viewModel: PersonViewModel
    
    var personToEdit: Person?
    
    @State private var name: String = ""
    @State private var age: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                TextField("Enter Name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                TextField("Enter Age", text: $age)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle(personToEdit == nil ? "Add Person" : "Edit Person")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let person = personToEdit {
                            viewModel.updatePerson(person: person, name: name, age: Int(age) ?? 0, context: context)
                        } else {
                            viewModel.addPerson(name: name, age: Int(age) ?? 0, context: context)
                        }
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .onAppear {
                if let person = personToEdit {
                    name = person.name
                    age = "\(person.age)"
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
}


#Preview {
    PersonFormView(viewModel: PersonViewModel())
}
