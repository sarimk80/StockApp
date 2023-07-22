//
//  StockService.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import Foundation

class StockService: ServiceProtocol {
        
    func forexExchangePoly(fromCurrency: String, toCurrency: String) async throws -> ForexExchangePolyModel {
        guard let url = URL(string: "https://api.polygon.io/v2/aggs/ticker/C:\(fromCurrency + toCurrency)/prev?adjusted=true&apiKey=\(Helper.POLYGON_API_KEY)")
        else {  throw URLError(.badURL) }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        
        guard let response = response as? HTTPURLResponse,
              
                response.statusCode == 200
                
                
        else { throw URLError(.badServerResponse) }
        
        if let string = String(data: data, encoding: .utf8) {
                    print(string)
                }
        
        
        let decodeResponse = try JSONDecoder().decode(ForexExchangePolyModel.self, from: data)
        
        return decodeResponse
    }
    
    
    
    
    func forexExchange(fromCurrency:String,toCurrency:String) async throws -> ForexExchangeModel {
        guard let url = URL(string: "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=\(fromCurrency)&to_currency=\(toCurrency)&apikey=\(Helper.API_kEY)")
        else {  throw URLError(.badURL) }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        
        guard let response = response as? HTTPURLResponse,
              
                response.statusCode == 200
                
                
        else { throw URLError(.badServerResponse) }
        
        let decodeResponse = try JSONDecoder().decode(ForexExchangeModel.self, from: data)
        
        return decodeResponse
    }
    
    
    func newsSentiment() async throws -> NewSentimentModel {
        guard let url = URL(string: "https://www.alphavantage.co/query?function=NEWS_SENTIMENT&apikey=\(Helper.API_kEY)")
        else {  throw URLError(.badURL) }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        
        guard let response = response as? HTTPURLResponse,
              
                response.statusCode == 200
                
                
        else { throw URLError(.badServerResponse) }
        
        let decodeResponse = try JSONDecoder().decode(NewSentimentModel.self, from: data)
        
        return decodeResponse
    }
    
    
    
    
    func topTraded() async throws -> TopTraded {
        guard let url = URL(string: "https://www.alphavantage.co/query?function=TOP_GAINERS_LOSERS&apikey=\(Helper.API_kEY)")
        else {  throw URLError(.badURL) }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        
        guard let response = response as? HTTPURLResponse,
              
                response.statusCode == 200
                
                
        else { throw URLError(.badServerResponse) }
        
        let decodeResponse = try JSONDecoder().decode(TopTraded.self, from: data)
        
        return decodeResponse
        
    }
    
    
    func previousClose(sym: String) async throws -> IntraDay {
        guard let url = URL(string: "https://api.polygon.io/v2/aggs/ticker/\(sym)/prev?adjusted=true&apiKey=\(Helper.POLYGON_API_KEY)")
        else {  throw URLError(.badURL) }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        
        guard let response = response as? HTTPURLResponse,
              
                response.statusCode == 200
                
                
        else { throw URLError(.badServerResponse) }
        
        
        let decodeResponse = try JSONDecoder().decode(IntraDay.self, from: data)
        
        return decodeResponse
    }
    
    func tickerDetail(sym: String) async throws -> IntraDay {
        guard let url = URL(string: "https://api.polygon.io/v2/aggs/ticker/\(sym)/range/5/day/1673089582/1688727933326?adjusted=true&sort=asc&limit=120&apiKey=\(Helper.POLYGON_API_KEY)")
        else {  throw URLError(.badURL) }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        
        guard let response = response as? HTTPURLResponse,
              
                response.statusCode == 200
                
                
        else { throw URLError(.badServerResponse) }
        
        
        let decodeResponse = try JSONDecoder().decode(IntraDay.self, from: data)
        
        return decodeResponse
    }
    
    func searchTicker(sym: String) async throws -> SearchSym {
        guard let url = URL(string: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(sym)&apikey=\(Helper.API_kEY)")
        else {  throw URLError(.badURL) }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        
        guard let response = response as? HTTPURLResponse,
              
                response.statusCode == 200
                
                
        else { throw URLError(.badServerResponse) }
        
        let decodeResponse = try JSONDecoder().decode(SearchSym.self, from: data)
        
        return decodeResponse
    }
    
    
    
}
