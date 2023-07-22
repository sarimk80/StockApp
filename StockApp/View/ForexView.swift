//
//  ForexView.swift
//  StockApp
//
//  Created by sarim khan on 17/07/2023.
//

import SwiftUI

struct ForexView: View {
    
    @State private var forexViewModel = ForexViewModel(stockService: StockService())
   
    
    var body: some View {
        VStack{
                VStack(spacing:24){
                    HStack{
                        Text(forexViewModel.firstCurrencyCode)
                        Image(systemName: "chevron.down")
                            .padding(.trailing,16)
                            .onTapGesture {
                                forexViewModel.showFirstSheet.toggle()
                            }
                        TextField("Enter amount", text: $forexViewModel.firstCurrency)
                            .frame(maxWidth: UIScreen.main.bounds.size.width * 0.6)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    .padding(.top,16)
                    HStack{
                        Text(forexViewModel.secondCurrencyCode)
                        Image(systemName: "chevron.down")
                            .padding(.trailing,16)
                            .onTapGesture {
                                forexViewModel.showSecondSheet.toggle()
                            }
                        TextField("Enter amount", text: $forexViewModel.secondCurrency)
                            .frame(maxWidth: UIScreen.main.bounds.size.width * 0.6)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    
                    Text("\(forexViewModel.exchangeValue , specifier: "%.2f")")
                    
                    if(forexViewModel.isLoading) {
                        ProgressView()
                    }
                    
                    
                    Spacer()
                }
                .onChange(of: [forexViewModel.firstCurrency,forexViewModel.secondCurrency], initial: true, {
                    forexViewModel.calculateCurrencyExchange()
                })
                .sheet(isPresented: $forexViewModel.showFirstSheet) {
                    MyPickerView(myCurrencyCode: $forexViewModel.firstCurrencyCode, currencyCode: $forexViewModel.searchCurrencyModel,forexViewModel: $forexViewModel)
                }
                .sheet(isPresented: $forexViewModel.showSecondSheet) {
                    MyPickerView(myCurrencyCode: $forexViewModel.secondCurrencyCode, currencyCode: $forexViewModel.searchCurrencyModel,forexViewModel: $forexViewModel)
                }
                
            
            
        }
        .navigationTitle("Forex")
        .onAppear {
            forexViewModel.readCsv(inputFile: "physical_currency_list.csv")
            forexViewModel.dataw()
        }
        .onChange(of: [forexViewModel.firstCurrencyCode,forexViewModel.secondCurrencyCode], initial: true) {
            Task{
                    await forexViewModel.currencyExchangeRate()

            }
        }
        
    }
}

struct MyPickerView:View {
    
    @Binding var myCurrencyCode : String
    @Binding var currencyCode : [CurrencyModel]
    @Binding var forexViewModel: ForexViewModel
    
    var body: some View {
        
        VStack{
            
            TextField("Search", text: $forexViewModel.searchTextField)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Picker("Picker", selection: $myCurrencyCode) {
                ForEach(currencyCode) { datum in
                    HStack(spacing:16){
                        Text(datum.currencyName)
                        Spacer()
                        Text(datum.currencyCode)
                    }
                    
                }
            }
            .pickerStyle(.wheel)
            .presentationDetents([.medium])
            
        }
        .padding()
        .onChange(of: forexViewModel.searchTextField, initial: false) { oldValue, newValue in
            
           forexViewModel.searchCountry()
            
        }
        
       
    }
}


#Preview {
    NavigationStack{
        ForexView()
    }
}
