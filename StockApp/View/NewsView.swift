//
//  NewsView.swift
//  StockApp
//
//  Created by sarim khan on 13/07/2023.
//

import SwiftUI

struct NewsView: View {
    @State private var newsViewModel = NewsViewModel(stockService: StockService())
    var body: some View {
        VStack {
            switch newsViewModel.newsViewState{
            case .initial:
                ProgressView()
            case .loading:
                ProgressView()
            case .loaded(let data):
                
                List(data.feed,id: \.timePublished){feed in
                    
                    Link(destination: URL(string: feed.url)!, label: {
                        VStack(alignment:.leading){
                            AsyncImage(url: URL(string: feed.bannerImage)) { image in
                                image.resizable()
                                    .frame(maxWidth:.infinity,maxHeight:150)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } placeholder: {
                                ProgressView()
                            }

                                
                                
                            Text(feed.title)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .padding(.bottom,6)
                            
                            Text(feed.summary)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .lineLimit(2)
                            
                        }
                    })
                    
                   
                    
                }
                .listStyle(.plain)
            case .error(let error):
                Text(error)
            }
        }
        .navigationTitle("News")
        .task {
            await newsViewModel.getNewsAndSentiment()
        }
    }
}

#Preview {
    
    NavigationStack{
        NewsView()
    }
}
