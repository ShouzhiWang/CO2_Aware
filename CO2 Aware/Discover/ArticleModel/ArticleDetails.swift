//
//  ArticleDetails.swift
//  CO2 Aware
//
//  Created by 王首之 on 11/20/22.
//

import SwiftUI


struct ArticleDetails: View {
    @EnvironmentObject var modelData : ModelData
    @State private var openSafari: Bool = false
    var article: Article
    
    
    var body: some View {
        ScrollView{
            
            
            article.image
                .resizable()
                .aspectRatio(3 / 2, contentMode: .fit)
                .overlay {
                    TextOverlay(article: article)
                }
            
            
            if !article.date.isEmpty {
                Text("Date Published: \(article.date)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
            }
            
            Text(.init(article.content))
                .padding(.all)
            
            Button(action: {
                openSafari.toggle()
            }) {
                Text("🔗View Original Article on \(article.author)")
                    .padding(22)
                    .background(Color("AccentColor"))
                    .foregroundColor(Color("WB"))
                    .font(Font.body.bold())
            }.frame(height: 50)
             .background(Color("AccentColor")).cornerRadius(10)
            
        }
        .hideTabBar(animated: true)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $openSafari, content: {
            SFSafariViewWrapper(url: URL(string: "\(article.link)")!)
                .ignoresSafeArea()
        })
    }


    
            
            
        }


struct ArticleDetails_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        ArticleDetails(article: modelData.articles[0])
            .environmentObject(modelData)
    }
}
