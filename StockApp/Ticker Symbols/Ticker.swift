//
//  Ticker.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import SwiftUI
import Observation

struct Ticker: View {
    
    @State private var tickerViewModel = TickerViewModel(stockService: StockService())
    @EnvironmentObject var appNavigation: AppNavigation
    
    @State var task: Task<Void, Never>? = nil
    
    var body: some View {
        VStack{
            switch tickerViewModel.tickerState{
            case .Initial:
                Button {
                    print("TAP")
                } label: {
                    Text("Search ticker")
                }

            case .Loading:
                ProgressView()
            case .Loaded(let data):
                List(data.bestMatches,id:\.self){bestMatches in
                    
                    HStack{
                        Text(bestMatches.the1Symbol)
                        Spacer()
                        Text(bestMatches.the2Name)
                        
                    }
                    .onTapGesture {
                        appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: bestMatches.the1Symbol))
                    }
                    
                    
                }
            case .Error(let error):
                Text(error)
                    
            }
        }
        .searchable(text: $tickerViewModel.searchSymbol,prompt: "Search Ticker")
        .navigationTitle("Symbol")
        .onChange(of: tickerViewModel.searchSymbol, initial: false) { oldValue, newValue in
            
            self.task?.cancel()
            
            self.task = Task(priority: .medium) {
                await tickerViewModel.getSearchStock()
            }
            
        }
        
        
    }
}

#Preview {
    NavigationStack{
        Ticker()
    }
}
