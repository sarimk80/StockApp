//
//  TickerViewModel.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import Foundation
import Observation
import SwiftUI

enum TickerState {
    case Initial
    case Loading
    case Loaded(data:SearchSym)
    case Error(error:String)
    
}



@Observable class TickerViewModel{
    
    var searchSymbol:String = ""
    var tickerState:TickerState = TickerState.Initial
    
    private let stockService:StockService
    
    
    init(stockService: StockService) {
        self.stockService = stockService
    }
    
    func getSearchStock() async {
        
        self.tickerState = TickerState.Loading
        
        if(searchSymbol.isEmpty){ self.tickerState = TickerState.Initial }
        
        if(!searchSymbol.isEmpty && searchSymbol.count > 1){
            do{
                try await Task.sleep(nanoseconds: 3_000_000_000)
                let data = try await self.stockService.searchTicker(sym: searchSymbol.capitalized)
                self.tickerState = TickerState.Loaded(data: data)
                
            }
            catch let error {
                self.tickerState = TickerState.Error(error: error.localizedDescription)
            }
        }
        
    }
    
    
}
