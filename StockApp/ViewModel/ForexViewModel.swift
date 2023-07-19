//
//  ForexViewModel.swift
//  StockApp
//
//  Created by sarim khan on 17/07/2023.
//

import Foundation
import Observation

enum ForexViewState {
    case initial
    case loading
    case loaded(data:[CurrencyModel])
    case error(error:String)
}

@Observable class ForexViewModel {
    
    @ObservationTracked  var forexViewState = ForexViewState.initial
    @ObservationTracked var firstCurrency = ""
    @ObservationTracked var secondCurrency = ""
    @ObservationTracked var firstCurrencyCode = "USD"
    @ObservationTracked var secondCurrencyCode = "AED"
    var searchTextField = ""
    var currencyModel:[CurrencyModel] = []
    var searchCurrencyModel:[CurrencyModel] = []
    
    
    
    func readCsv(inputFile:String)  {
        self.forexViewState = ForexViewState.loading
        if let filepath = Bundle.main.path(forResource: inputFile, ofType: nil) {
            do {
                let fileContent = try String(contentsOfFile: filepath)
                let lines = fileContent.components(separatedBy: "\n")
                lines.dropFirst().forEach { line in
                    let data = line.components(separatedBy: ",")
                    if data.count == 2 {
                        currencyModel.append(CurrencyModel(currencyCode: data[0], currencyName: data[1]))
                        searchCurrencyModel.append(CurrencyModel(currencyCode: data[0], currencyName: data[1]))
                    }
                }
                self.forexViewState = ForexViewState.loaded(data: currencyModel)
            } catch {
                print("error: \(error)") // to do deal with errors
                self.forexViewState = ForexViewState.error(error: error.localizedDescription)
            }
        } else {
            print("\(inputFile) could not be found")
            self.forexViewState = ForexViewState.error(error: "\(inputFile) could not be found")
        }
    }
    
    
    
    func searchCountry() {
        
        if(!searchTextField.isEmpty) {
            searchCurrencyModel = searchCurrencyModel.filter{ $0.currencyName.contains(searchTextField) }
        }else{
            searchCurrencyModel = currencyModel

        }
        
        
        //return searchCurrencyModel
    }
}
    

