//
//  TopSymbols.swift
//  StockApp
//
//  Created by sarim khan on 11/07/2023.
//

import SwiftUI


enum Option: String, CaseIterable {
    case Gainers
    case Losers
    case Active
}

struct TopSymbols: View {
    
    @State var options:Option = Option.Gainers
    @State private var topSymbolViewModel = TopSymbolsViewModel(stockService: StockService())
    @EnvironmentObject var appNavigation: AppNavigation
    
    
    var body: some View {
        VStack{
            Picker("Picker", selection: $options) {
                ForEach(Option.allCases,id:\.self){value in
                    Text(value.rawValue)
                }
            }
            .padding(.top,8)
            .pickerStyle(.segmented)
            
            Spacer()
            
            switch topSymbolViewModel.topSymbolState {
            case .initial:
                ProgressView()
            case .loading:
                ProgressView()
            case .loaded(let data):
                switch options {
                case .Gainers:
                    MyCustomList(mostActivelyTraded: data.topGainers,appNavigation: appNavigation)
                case .Losers:
                    MyCustomList(mostActivelyTraded: data.topLosers,appNavigation: appNavigation)
                case .Active:
                    MyCustomList(mostActivelyTraded: data.mostActivelyTraded,appNavigation: appNavigation)
                }
            case .error(let error):
                Text(error)
            }
            
            Spacer()
            
        }
        .navigationTitle("Top Tickers")
        .task {
           await topSymbolViewModel.getTopTradedTicker()
        }
    }
}

struct MyCustomList: View {
    var mostActivelyTraded:[MostActivelyTraded]
    @ObservedObject  var appNavigation:AppNavigation
    var body: some View {
        List(mostActivelyTraded,id: \.ticker) { trade in
            HStack{
                Text(trade.ticker)
                Spacer()
                VStack(alignment:.trailing){
                    Text(trade.price)
                    Text(trade.volume)
                        .font(.caption)
                        .fontWeight(.light)
                }
                .padding(.trailing,16)
                VStack(alignment:.trailing){
                    Text(trade.changeAmount)
                    Text(trade.changePercentage)
                        
                }
                .foregroundStyle(textColor(changeAmount: trade.changeAmount))
                
                
            }
            .onTapGesture {
                appNavigation.topTickerNavigation.append(TickerViewRoute.tickerDetail(sym: trade.ticker))
            }
            
        }
        .listStyle(.plain)
    }
}


func textColor(changeAmount:String) -> Color {
    if(changeAmount.contains("-")) { return .red }
    return .green
}


#Preview {
    NavigationStack{
        TopSymbols()
    }
}
