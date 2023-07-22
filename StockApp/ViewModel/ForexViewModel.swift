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
    @ObservationTracked var firstCurrency = "1"
    @ObservationTracked var secondCurrency = ""
    @ObservationTracked var firstCurrencyCode = "USD"
    @ObservationTracked var secondCurrencyCode = "AED"
    var searchTextField = ""
    var currencyModel:[CurrencyModel] = []
    var searchCurrencyModel:[CurrencyModel] = []
    var showFirstSheet = false
    var showSecondSheet = false
    var isLoading = false
    var exchangeValue:Double = 0.0
    
    private let stockService:StockService
    
    init(stockService: StockService) {
        self.stockService = stockService
    }
    
    func dataw(){
        withObservationTracking {
            print(firstCurrency)
        } onChange: {
            print(String(Double(self.secondCurrency) ?? 0.0 * (Double(self.firstCurrency) ?? 0.0) ))
        }

    }
    
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
            if(showFirstSheet){
                self.firstCurrencyCode = searchCurrencyModel.first?.currencyCode ?? "USD"
            }
            if(showSecondSheet){
                self.secondCurrencyCode = searchCurrencyModel.first?.currencyCode ?? "AED"
            }
        }else{
            searchCurrencyModel = currencyModel
            
        }
    }
    
    
    func currencyExchangeRate() async{
        
        do{
            self.isLoading = true
            self.firstCurrency = "1"
            let data = try await self.stockService.forexExchangePoly(fromCurrency: firstCurrencyCode, toCurrency: secondCurrencyCode)
            self.secondCurrency =  String(format: "%.2f", data.myResults.first?.c ?? 0.0) 
            self.isLoading = false
        }catch let error {
            print(error.localizedDescription)
            self.isLoading = false
        }
    }
    
    func calculateCurrencyExchange(){
        
        let doubleFirstCurrency = Double(firstCurrency) ?? 0.0
        let dobuleSecondCurrency = Double(secondCurrency) ?? 0.0
        
        exchangeValue = Double(doubleFirstCurrency  * dobuleSecondCurrency)
    }
    
}
    

