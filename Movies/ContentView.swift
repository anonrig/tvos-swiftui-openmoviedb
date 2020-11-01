//
//  ContentView.swift
//  Movies
//
//  Created by Yagiz Nizipli on 11/1/20.
//

import SwiftUI
import Combine
import Hover
import KingfisherSwiftUI

struct ContentView: View {
  
  @ObservedObject var viewModel: ViewModel = .init()
  
  var body: some View {
    List {
      Text("Star Wars Movies")
        .font(.largeTitle)
        .padding()
        .listRowInsets(.init())
        .listRowBackground(Color.clear)
      
      ScrollView(.horizontal) {
        LazyHStack(spacing: 0) {
          ForEach(viewModel.starwars) { movie in
            Button(action: {}) {
              MovieCard(movie: movie)
            }
            .buttonStyle(CardButtonStyle())
            .padding(75)
          }
        }
        .padding(-40)
      }
      .listRowInsets(.init())
      .listRowBackground(Color.clear)
      
      Text("Marvel Movies")
        .font(.largeTitle)
        .padding()
        .listRowInsets(.init())
        .listRowBackground(Color.clear)
      
      ScrollView(.horizontal) {
        LazyHStack(spacing: 20) {
          ForEach(viewModel.marvel) { movie in
            Button(action: {}) {
              MovieCard(movie: movie)
            }
            .buttonStyle(CardButtonStyle())
            .padding(75)
          }
        }
        .padding(-40)
      }
      .listRowInsets(.init())
      .listRowBackground(Color.clear)
    }
  }
}

struct MovieCard: View {
  let movie: Movie
  
  var body: some View {
    ZStack {
      KFImage(movie.posterUrl)
        .resizable()
        .frame(width: 500, height: 500)
        .scaledToFill()
        .clipped()
      VStack {
        Spacer()
        Text(movie.Title).font(.headline)
          .lineLimit(1)
      }
      .frame(maxWidth: 500)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension ContentView {
  
  final class ViewModel: ObservableObject {
    
    @Published var starwars: [Movie] = []
    @Published var marvel: [Movie] = []
    private let provider = Hover()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
      fetchStarwars()
      fetchMarvel()
    }
    
    func fetchStarwars() {
      provider
        .request(
          with: MovieTarget.search(title: "star"),
          scheduler: RunLoop.main,
          class: SearchResponse.self
        )
        .replaceError(with: .init(Search: []))
        .map { $0.Search }
        .assign(to: \.starwars, on: self)
        .store(in: &subscriptions)
    }
    
    func fetchMarvel() {
      provider
        .request(
          with: MovieTarget.search(title: "marvel"),
          scheduler: RunLoop.main,
          class: SearchResponse.self
        )
        .replaceError(with: .init(Search: []))
        .map { $0.Search }
        .assign(to: \.marvel, on: self)
        .store(in: &subscriptions)
    }
  }
}

struct SearchResponse: Codable {
  let Search: [Movie]
}
