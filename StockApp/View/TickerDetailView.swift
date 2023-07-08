//
//  TickerDetailView.swift
//  StockApp
//
//  Created by sarim khan on 06/07/2023.
//

import SwiftUI
import Charts

struct TickerDetailView: View {
    
    @State private var tickerDetailViewModel:TickerDetailViewModel = TickerDetailViewModel(stockService: StockService())
    
    var sym : String
    
    var body: some View {
        VStack(alignment:.leading){
            switch tickerDetailViewModel.tickerDetailState{
            case .Initial:
                ProgressView()
                
            case .Loading:
                ProgressView()
            case .Loaded(let data,let previousClose):
                    Chart{
                        ForEach(data.results){value in
                            LineMark(
                                x: .value("Shape Type", value.customDate),
                                y: .value("Total Count", value.c)
                            )
                            .foregroundStyle(.purple)
                            
                            AreaMark(x: .value("x", value.customDate), yStart: .value("start", data.results.map { $0.c }.min()! ), yEnd: .value("end", value.c))
                                .foregroundStyle(.purple.opacity(0.2))
                        }
                    }
                    .clipShape(Rectangle())
                    .chartYScale(domain: data.results.map { $0.c }.min()! ... (data.results.map { $0.c }.max()!) )
                    .frame(height:350)
                
                
                    Spacer()
                    VStack(alignment:.leading){
                        Text("High \(previousClose.results.first!.h)")
                        Text("Low \(previousClose.results.first!.l)")
                        Text("Open \(previousClose.results.first!.o)")
                        Text("Close \(previousClose.results.first!.c)")
                        Text("Volume \(previousClose.results.first!.v)")
                        Text(" \( Date(timeIntervalSince1970: Double((previousClose.results.first!.t)/1000)) )")
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    Spacer()
 
                
            case .Error(let error):
                Text(error)
            }
        }
        .padding()
        .navigationTitle(sym)
        .task {
            await tickerDetailViewModel.getTickerDetail(sym: sym)
        }
    }
}

#Preview {
    NavigationStack{
        TickerDetailView(sym: "AAPL")
        
    }
}
