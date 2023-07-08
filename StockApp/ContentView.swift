//
//  ContentView.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import SwiftUI

struct ContentView: View {
       
    @StateObject private var appNavigation = AppNavigation()
    
    var body: some View {
            TabView {
                NavigationStack(path: $appNavigation.tickerNavigation){
                    Ticker()
                        .environmentObject(appNavigation)
                        .navigationDestination(for: TickerViewRoute.self) { route in
                            switch route{
                                case .tickerDetail(let symbol):
                                    TickerDetailView(sym: symbol)
                            }
                        }
                }
                    .tabItem { Label("Ticker", systemImage: "chart.bar.xaxis") }
                
                NavigationStack{
                    Text("Top Symbols")
                }
                    .tabItem { Label("Top Symbols", systemImage: "chart.line.downtrend.xyaxis") }
                
                NavigationStack{
                    Text("News")
                }
               
                    .tabItem { Label("News", systemImage: "newspaper") }
                
                NavigationStack{
                    Text("Forex")
                }
                
                    .tabItem { Label("Forex", systemImage: "dollarsign") }
                
                NavigationStack{
                    Text("Commodity")
                }
                
                
                    .tabItem { Label("Commodity", systemImage: "oilcan") }
                
                NavigationStack{
                    Text("Crypto")
                }
                
               
                    .tabItem { Label("Crypto", systemImage: "bitcoinsign") }
                
                NavigationStack{
                    Text("Economics")
                }
                    .tabItem { Label("Economics", systemImage: "building.columns") }
                
               
            }
        
        
    }

}

#Preview {
    ContentView()
}
