//
//  slideShow.swift
//  DesertGame
//
//  Created by Raghad  on 30/06/1446 AH.
//

import SwiftUI


struct SlidingPagesView: View {
    @State private var showStartingPage: Bool = false
    
    var body: some View {
        if showStartingPage {
            StartingPage()
        } else {
            TabView {
                PageView(content: "ثبت الهاتف عموديًا!")
                    .accessibilityLabel("ثبت الهاتف عموديًا!")
                    .background(Color.black)
                    .tag(0)
                
                PageView(content: "دع انتباهك علي تفاصيل الاصوات!")
                    .accessibilityLabel("دع انتباهك على تفاصيل الاصوات!")
                    .background(Color.black)
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .ignoresSafeArea()
            .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showStartingPage = true
                }
            }
        }
    }
}

struct PageView: View {
    var content: String
    
    var body: some View {
        VStack {
            Text(content)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct SlidingPagesView_Previews: PreviewProvider {
    static var previews: some View {
        SlidingPagesView()
    }
}
