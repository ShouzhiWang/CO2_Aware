//
//  FeatureCard.swift
//  CO2 Aware
//
//  Created by 王首之 on 11/20/22.
//  Source: https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit


import SwiftUI

struct FeatureCard: View {
    var article: Article
    
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        NavigationLink{
            ArticleDetails(article: article)
            
        }label: {
            article.featureImage?
                .resizable()
                .aspectRatio(3 / 2, contentMode: .fit)
                .overlay {
                    TextOverlay(article: article)
                }
        }
        
        
    }
}


struct TextOverlay: View {
    var article: Article
    
    var gradient: LinearGradient {
        .linearGradient(Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
                        startPoint: .bottom, endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            gradient
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                Text(article.author)
                
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}
struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(article: ModelData().features[0])
    }
}
