//
//  TickerDetailViewModel.swift
//  StockApp
//
//  Created by sarim khan on 06/07/2023.
//

import Foundation
import Observation


enum TickerDetailState {
 case Initial
    case Loading
    case Loaded(data:IntraDay,previousClose:IntraDay)
    case Error(error:String)
}
 
@Observable class TickerDetailViewModel {
    
    private let stockService:StockService
    var tickerDetailState:TickerDetailState = TickerDetailState.Initial
    
    
    init(stockService: StockService) {
        self.stockService = stockService
    }
    
    func getTickerDetail(sym:String) async {
        self.tickerDetailState = TickerDetailState.Loading
        do{
            let data = try await self.stockService.tickerDetail(sym: sym)
            let previousClose = try await self.stockService.previousClose(sym: sym)
            self.tickerDetailState = TickerDetailState.Loaded(data: data,previousClose: previousClose)
            
        }catch let error {
            self.tickerDetailState = TickerDetailState.Error(error: error.localizedDescription)
        }
    }
    
    
}
