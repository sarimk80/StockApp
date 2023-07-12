//
//  TopSymbolsViewModel.swift
//  StockApp
//
//  Created by sarim khan on 11/07/2023.
//

import Foundation
import Observation


enum TopSymbolState {
    case initial
    case loading
    case loaded(data:TopTraded)
    case error(error:String)
}


@Observable
class TopSymbolsViewModel {
    
    var topSymbolState:TopSymbolState = TopSymbolState.initial
    
    private let stockService:StockService
    
    init(stockService: StockService) {
        self.stockService = stockService
    }
    
    
    func getTopTradedTicker() async {
        self.topSymbolState = TopSymbolState.loading
        do{
            let data = try await self.stockService.topTraded()
            self.topSymbolState = TopSymbolState.loaded(data: data)
        }catch let error{
            self.topSymbolState = TopSymbolState.error(error: error.localizedDescription)
        }
    }
    
    
}
