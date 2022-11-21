//
//  OtherArticles.swift
//  CO2 Aware
//
//  Created by 王首之 on 11/21/22.
//

import SwiftUI

struct OtherArticles: View {
    @EnvironmentObject var modelData: ModelData
    var article: Article
    
    var body: some View {
        NavigationLink{
            ArticleDetails(article: article)
            
        }label: {
            HStack{
            
                article.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130, height: 130, alignment: .center)
                    .clipped()
                
                
                Text(article.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 3.0)
                    
                        

                
                Spacer()
            }
            

        }
        
    }
}

struct OtherArticles_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        OtherArticles(article: modelData.articles[0])
            .environmentObject(modelData)
    }
}
