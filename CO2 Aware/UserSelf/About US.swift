//
//  About US.swift
//  CO2 Aware
//
//  Created by 王首之 on 12/21/22.
//

import SwiftUI

struct About_US: View {
    @State private var inAnimation = false
    @State private var buttonIn = false
    @State private var feedbackIn = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Image("Icon")
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(40)
            .scaleEffect(inAnimation ? 1: 0, anchor: .bottom)
            
            Text("CO2 Aware")
                .font(.largeTitle)
                .bold()
            .scaleEffect(inAnimation ? 1: 0, anchor: .bottom)
            
            Text("Developed by Shawn Wang")
                .scaleEffect(buttonIn ? 1: 0, anchor: .center)
            Text("Special thanks to Ryan Wu")
                .scaleEffect(buttonIn ? 1: 0, anchor: .center)
            
            
            if feedbackIn {
                Text("Please send any feedback to \nshoguns.lenses.0s@icloud.com")
                    .font(.caption2)
                    .padding(.top)
            }
            Spacer()
                .frame(height: 150)
            
            Button{
                dismiss()
            }label: {
            
                Image(systemName: "arrow.left.circle")
                
                    .font(.largeTitle)
            }
            .scaleEffect(buttonIn ? 1: 0, anchor: .leading)
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
        
        .background(
            Image("HomeLvl2")
                .resizable()
                .ignoresSafeArea()
            
                .padding(-10)
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                inAnimation = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    buttonIn = true
                }
                
                
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    feedbackIn = true
                }
            }
        }
        .navigationBarHidden(true)
    }
    
}

struct About_US_Previews: PreviewProvider {
    static var previews: some View {
        About_US()
    }
}
