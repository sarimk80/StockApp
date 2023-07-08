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
}
