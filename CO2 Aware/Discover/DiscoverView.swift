//
//  DiscoverView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/17/22.
//

import SwiftUI
import HidableTabView

struct DiscoverView: View {
    
    @EnvironmentObject var modelData: ModelData

    // View that presents some news articles
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                List{
                    PageView(pages: modelData.features.map { FeatureCard(article: $0) })
                        .aspectRatio(3 / 2, contentMode: .fit)
                        .listRowInsets(EdgeInsets())
                    
                   
                    Section(footer: Text("🥳You've read all of them? We are adding more articles!\nPlease wait for further updates😙")){
                        
                        ForEach(modelData.others){ other in
                            OtherArticles(article: other)
                                .listRowInsets(EdgeInsets())
                            
                                
                        }
                    }
                    
                    
                    
                }
                .showTabBar(animated: true)
                .navigationBarTitle("Discover")
                .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
                
                
            }
            
        }
        .environmentObject(modelData)
        
    }

}

struct DiscoverView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        DiscoverView()
            .environmentObject(ModelData())
    }
}
