//
//  PageView.swift
//  CO2 Aware
//
//  Created by 王首之 on 11/20/22.
//  Source: https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit


import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
        }
        
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: ModelData().features.map { FeatureCard(article: $0) })
                    .aspectRatio(3 / 2, contentMode: .fit)
    }
}
