//
//  TakingTest.swift
//  CO2 Aware
//
//  Created by 王首之 on 6/10/23.
//

import SwiftUI
import UIKit

struct TakingTest: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var clicked = false
    @State private var openSafari = false
    @ObservedObject var p : UserProgress
    @State private var hasTimeElapsed = false

    let currentLanguageCode = Locale.current.languageCode
    var url: URL {
        if currentLanguageCode == "zh" {
            return URL(string: "https://wj.qq.com/s2/12544552/33fe/")!
        } else {
            return URL(string: "https://wj.qq.com/s2/12540293/7c65/")!
        }
    }
    var body: some View {
        ScrollView {
            
        
        VStack {
            if !clicked {
                Spacer()
                    .frame(height: 25)
                Image(systemName: "leaf")
                    .foregroundColor(.green)
                
                    .font(.system(size: 50))
                    .padding(.all)
                
                
                Text("Carbon footprint test")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("After you take the test, please remember your environmental impact and press the 'Done' button on the upper left corner.")
                    .padding(.all)
                
                Spacer()
                    .frame(height: 155)
                
                VStack{
                    HStack{
                        Image(systemName: "note.text")
                            .padding([.top, .leading, .trailing])
                            .foregroundColor(Color("Label"))
                        Spacer()
                    }
                    
                    
                    
                    Text("You will be directed to a website in order to fill the form. We may collect your response to better improve our product. You do not need to fill any sensitive information. All responses are vague.   \n\nSource: wikiHow")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .padding(.all)
                        .foregroundColor(Color("Label"))
                    
                }
                
                Button(action: {
                    clicked = true
                    openSafari = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                       hasTimeElapsed = true
                    }
                }) {
                    Text("Take me to the test")
                    
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                    
                        .padding()
                        .foregroundColor(Color("WB"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("WB"), lineWidth: 2)
                        )
                }
                .background(Color.accentColor)
                .cornerRadius(15)
                .padding(.horizontal)
            } else if clicked && hasTimeElapsed
                {
                Image(systemName: "person.crop.circle.badge.checkmark")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 50))
                    .padding(.all)
                
                
                Text("Done?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("What's your result?")
                    .padding(.all)
                    .font(.title2)
                
                Button {
                    p.tookTest(score: 1)
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    VStack {
                        Text("😄Excellent")
                            .frame(maxWidth: .infinity)
                            .padding([.top, .leading, .trailing])
                            .foregroundColor(.white)
                            .font(.title)
                        Text("You are making a small impact")
                            .frame(maxWidth: .infinity)
                            .padding([.leading, .bottom, .trailing])
                            .foregroundColor(.white)
                            .font(.caption)
                        
                    }
                    
                }.background(RoundedRectangle(cornerRadius: 20).fill(.green))
                    .padding(.horizontal)
                
                Button {
                    p.tookTest(score: 2)
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    VStack {
                        Text("😊Great")
                            .frame(maxWidth: .infinity)
                            .padding([.top, .leading, .trailing])
                            .foregroundColor(.white)
                            .font(.title)
                        Text("Your lifestyle is environmental friendly")
                            .frame(maxWidth: .infinity)
                            .padding([.leading, .bottom, .trailing])
                            .foregroundColor(.white)
                            .font(.caption)
                        
                    }
                    
                }.background(RoundedRectangle(cornerRadius: 20).fill(.blue))
                    .padding(.horizontal)
                
                Button {
                    p.tookTest(score: 3)
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    VStack {
                        Text("🧐Ummm")
                            .frame(maxWidth: .infinity)
                            .padding([.top, .leading, .trailing])
                            .foregroundColor(.white)
                            .font(.title)
                        Text("Your environmental impact is somewhat high")
                            .frame(maxWidth: .infinity)
                            .padding([.leading, .bottom, .trailing])
                            .foregroundColor(.white)
                            .font(.caption)
                        
                    }
                    
                }.background(RoundedRectangle(cornerRadius: 20).fill(.orange))
                    .padding(.horizontal)
                
                Button {
                    p.tookTest(score: 4)
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    VStack {
                        Text("🥺Not good")
                            .frame(maxWidth: .infinity)
                            .padding([.top, .leading, .trailing])
                            .foregroundColor(.white)
                            .font(.title)
                        Text("Your lifestyle is causing a significant negative impact")
                            .frame(maxWidth: .infinity)
                            .padding([.leading, .bottom, .trailing])
                            .foregroundColor(.white)
                            .font(.caption)
                        
                    }
                    
                }.background(RoundedRectangle(cornerRadius: 20).fill(.red))
                    .padding(.horizontal)
                
                
                
                Spacer()
                
                Button {
                    p.tookTest(score: 0)
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    VStack {
                        Text("☝🏻I didn't finish")
                            .frame(maxWidth: .infinity)
                            .padding([.top, .leading, .trailing])
             
                    }
                    
                }
                .padding(.horizontal)
            } else {
                
            }
        }
    }
            .hideTabBar(animated: true)
            .fullScreenCover(isPresented: $openSafari, content: {
                SFSafariViewWrapper(url: url)
                    .ignoresSafeArea()
            })
        
            
        
    }
    
    
//    private func delayText() async {
//            // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
//            try? await Task.sleep(nanoseconds: 1_500_000_000)
//            hasTimeElapsed = true
//        }
        
}

struct TakingTest_Previews: PreviewProvider {
    static var previews: some View {
        TakingTest(p: UserProgress())
    }
}
