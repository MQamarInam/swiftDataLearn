//
//  APIView.swift
//  swiftDataLearn
//
//  Created by Qaim's Macbook  on 12/09/2025.
//

import SwiftUI
import SwiftData

struct Result: Codable {
    let pagination: Pagination
    let data: [MyData]
}

struct Pagination: Codable {
    let total: Int
    let limit: Int
}

struct MyData: Codable, Identifiable {
    let id: Int
    let _score: Double
    let api_model: String
    let title: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let width: Int
    let height: Int
    let alt_text: String
}

class ResultViewModel: ObservableObject {
    
    @Published var result: Result?
    
    func fetchData() async {
        
        do {
            guard let url = URL(string: "https://api.artic.edu/api/v1/artworks/search?q=cats") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = try JSONDecoder().decode(Result.self, from: data)
            await MainActor.run {
                self.result = decoder
            }
        } catch {
            print("Error")
        }
        
    }
    
}

struct APIView: View {
    
    @StateObject var vm: ResultViewModel = ResultViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let result = vm.result {
                VStack(alignment: .leading) {
                    Text("\(result.pagination.limit)")
                    Text("\(result.pagination.total)")
                }
                .padding()
                List(result.data) { art in
                    VStack(alignment: .leading) {
                        Text(art.title)
                        Text(art.api_model)
                        Text("\(art._score)")
                        Text("Width: \(art.thumbnail.width), Height: \(art.thumbnail.height)")
                        Text(art.thumbnail.alt_text)
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.cyan.opacity(0.3))
                    .cornerRadius(8)
                }
                .listStyle(PlainListStyle())
            }
        }
        .task {
            await vm.fetchData()
        }
    }
    
}

#Preview {
    APIView()
}
