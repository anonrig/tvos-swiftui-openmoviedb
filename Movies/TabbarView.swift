//
//  TabbarView.swift
//  Movies
//
//  Created by Yagiz Nizipli on 11/1/20.
//

import SwiftUI

struct TabbarView: View {
  
  var body: some View {
    TabView {
      NavigationView {
        ContentView().navigationBarHidden(true)
      }
        .tabItem {
          Text("Movies 1")
        }
        .tag("movies-1")
        .id("movies-1")
      
      NavigationView {
        ContentView().navigationBarHidden(true)
      }
        .tabItem {
          Text("Movies 2")
        }
        .tag("movies-2")
        .id("movies-2")
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .edgesIgnoringSafeArea(.all)
  }
}
