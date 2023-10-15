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
                .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
                .cornerRadius(UIDevice.current.userInterfaceIdiom == .pad ? 10 : 0)
            
            
            if !article.date.isEmpty {
                Text("Date Published: \(article.date)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
                
            }
            
            Text(.init(article.content))
                .padding(.all)
                .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
            
            Button(action: {
                openSafari.toggle()
            }) {
                Text("🔗View Original Article on \(article.author)")
                    .padding(22)
                    .background(Color("AccentColor"))
                    .foregroundColor(Color("WB"))
                    .font(Font.body.bold())
            }.frame(height: 50)
            .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
             .background(Color("AccentColor")).cornerRadius(10)
             .padding(.horizontal)
            
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
