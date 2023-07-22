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
                
                NavigationStack(path:$appNavigation.topTickerNavigation){
                    TopSymbols()
                        .environmentObject(appNavigation)
                        .navigationDestination(for: TickerViewRoute.self) { route in
                            switch route{
                            case .tickerDetail(let symbol):
                                TickerDetailView(sym: symbol)
                                
                            }
                        }
                }
                    .tabItem { Label("Top Symbols", systemImage: "chart.line.downtrend.xyaxis") }
                
                NavigationStack{
                    NewsView()
                }
               
                    .tabItem { Label("News", systemImage: "newspaper") }
                
                NavigationStack{
                    ForexView()
                }
                
                    .tabItem { Label("Forex", systemImage: "dollarsign") }
                
                
               
            }
        
        
    }

}

#Preview {
    ContentView()
}
