//
//  ForexView.swift
//  StockApp
//
//  Created by sarim khan on 17/07/2023.
//

import SwiftUI

struct ForexView: View {
    
    @State private var forexViewModel = ForexViewModel()
    @State private var firstCurrencyCode = "AED"
    @State private var SecondCurrencyCode = "USD"
    @State private var showFirstSheet = false
    @State private var showSecondSheet = false
    
    var body: some View {
        VStack{
                VStack(spacing:24){
                    HStack{
                        Text(forexViewModel.firstCurrencyCode)
                        Image(systemName: "chevron.down")
                            .padding(.trailing,16)
                            .onTapGesture {
                                self.showFirstSheet.toggle()
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
                                self.showSecondSheet.toggle()
                            }
                        TextField("Enter amount", text: $forexViewModel.secondCurrency)
                            .frame(maxWidth: UIScreen.main.bounds.size.width * 0.6)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    Spacer()
                }
                .sheet(isPresented: $showFirstSheet) {
                    MyPickerView(myCurrencyCode: $forexViewModel.firstCurrencyCode, currencyCode: $forexViewModel.searchCurrencyModel,forexViewModel: $forexViewModel)
                }
                .sheet(isPresented: $showSecondSheet) {
                    MyPickerView(myCurrencyCode: $forexViewModel.secondCurrencyCode, currencyCode: $forexViewModel.searchCurrencyModel,forexViewModel: $forexViewModel)
                }
                
            
            
        }
        .navigationTitle("Forex")
        .onAppear {
            forexViewModel.readCsv(inputFile: "physical_currency_list.csv")
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
