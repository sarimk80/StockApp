//
//  NewsViewModel.swift
//  StockApp
//
//  Created by sarim khan on 13/07/2023.
//

import Foundation
import Observation

enum NewsViewState{
    case initial
    case loading
    case loaded(data:NewSentimentModel)
    case error(error:String)
}

@Observable class NewsViewModel {
    var newsViewState = NewsViewState.initial
    
    private let stockService:StockService
    
    
    init(stockService: StockService) {
        URLCache.shared.memoryCapacity = 80_000_000 
        self.stockService = stockService
    }
    
    func getNewsAndSentiment()  async{
        self.newsViewState = NewsViewState.loading
        do{
            let data =  try await self.stockService.newsSentiment()
            self.newsViewState = NewsViewState.loaded(data: data)
        }catch let error{
            self.newsViewState = NewsViewState.error(error: error.localizedDescription)
        }
    }
}
