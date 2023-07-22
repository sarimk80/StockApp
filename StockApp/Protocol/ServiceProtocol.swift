//
//  ServiceProtocol.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import Foundation

protocol ServiceProtocol {
    func searchTicker(sym:String) async throws ->  SearchSym
    
    func tickerDetail(sym:String) async throws -> IntraDay
    
    func previousClose(sym:String) async throws -> IntraDay
    
    func topTraded() async throws -> TopTraded
    
    func newsSentiment() async throws -> NewSentimentModel
    
    func forexExchange(fromCurrency:String,toCurrency:String) async throws -> ForexExchangeModel
    
    func forexExchangePoly(fromCurrency:String,toCurrency:String) async throws -> ForexExchangePolyModel
}
