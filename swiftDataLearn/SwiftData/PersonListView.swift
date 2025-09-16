//
//  ContentView.swift
//  swiftDataLearn
//
//  Created by Qaim's Macbook  on 23/04/2025.
//

import SwiftUI
import SwiftData

struct PersonListView: View {
    
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = PersonViewModel()
    @State private var showFormView = false
    @State private var selectedPerson: Person? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if !viewModel.persons.isEmpty {
                    List {
                        ForEach(viewModel.persons) { person in
                            VStack(alignment: .leading) {
                                Text(person.name)
                                    .font(.headline)
                                Text("Age: \(person.age)")
                                    .foregroundColor(.gray)
                            }
                            .swipeActions {
                                Button("Delete", role: .destructive) {
                                    viewModel.deletePerson(person: person, context: context)
                                }
                                Button("Edit") {
                                    selectedPerson = person
                                    showFormView = true
                                }.tint(.blue)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Text("No Items")
                        .font(.title)
                }
                
            }
            .navigationTitle("Persons")
            .toolbar(content: {
                Button {
                    selectedPerson = nil
                    showFormView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                }

            })
            .onAppear {
                viewModel.fetchData(context: context)
            }
            .navigationDestination(isPresented: $showFormView, destination: {
                PersonFormView(viewModel: viewModel, personToEdit: selectedPerson)
            })
        }
    }
}

#Preview {
    PersonListView()
}
