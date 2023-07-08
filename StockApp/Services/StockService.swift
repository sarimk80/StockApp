//
//  StockService.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import Foundation

class StockService: ServiceProtocol {
    
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
