//
//  DiscoverView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/17/22.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        List(articles) { Article in
            Text(Article.title)
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
