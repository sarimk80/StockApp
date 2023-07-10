//
//  Ticker.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import SwiftUI
import Observation
import SwiftData

struct Ticker: View {
    
    @State private var tickerViewModel = TickerViewModel(stockService: StockService())
    @EnvironmentObject var appNavigation: AppNavigation
    @Environment(\.modelContext) private var modelContext
    
    @Query()
    var bestMatch: [BestMatch]
    
    @State var task: Task<Void, Never>? = nil
    
    var body: some View {
        VStack{
            switch tickerViewModel.tickerState{
            case .Initial:
                if(bestMatch.isEmpty || bestMatch.count <= 1){ Text("Search Ticker") }
                else { List(bestMatch){value in
                    HStack{
                        Text(value.the1Symbol)
                        Spacer()
                        Text(value.the2Name)
                    }
                    .onTapGesture {
                        appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: value.the1Symbol))
                    }
                    
                } }
                

            case .Loading:
                ProgressView()
            case .Loaded(let data):
                List(data.bestMatches,id:\.self){bestMatches in
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text(bestMatches.the1Symbol)
                                .padding(.bottom,4)
                            Text(bestMatches.the2Name)
                        }
                        .onTapGesture {
                            appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: bestMatches.the1Symbol))
                        }
                        
                        Spacer()
                        Button {
                            modelContext.insert(bestMatches)
                            
                        } label: {
                            Image(systemName: bestMatch.contains { value in value.the1Symbol == bestMatches.the1Symbol } ? "heart.fill" : "heart")
                        }

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
