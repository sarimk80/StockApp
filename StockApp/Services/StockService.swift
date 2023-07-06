//
//  StockService.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import Foundation

class StockService: ServiceProtocol {
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
