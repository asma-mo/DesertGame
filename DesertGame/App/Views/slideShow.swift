


import SwiftUI

struct SlidingPagesView: View {
    @State private var showStartingPage: Bool = false
    
    var body: some View {
        if showStartingPage {
            StartingPage()
        } else {
            TabView {
                PageView(content: "ثبت الهاتف عموديًا!", showSkip: false, skipAction: {})
                    .accessibilityLabel("ثبت الهاتف عموديًا!")
                    .background(Color.black)
                    .tag(0)
                
                PageView(content: "دع انتباهك علي تفاصيل الاصوات!", showSkip: true, skipAction: {
                    showStartingPage = true
                })
                    .accessibilityLabel("دع انتباهك على تفاصيل الاصوات!")
                    .background(Color.black)
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .ignoresSafeArea()
        }
    }
}

struct PageView: View {
    var content: String
    var showSkip: Bool
    var skipAction: () -> Void
    
    var body: some View {
        VStack {
            if showSkip {
                HStack {
                    Spacer()
                    Button(action: skipAction) {
                        Text("Skip")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .padding(.trailing)
            }
            
            Spacer()
            
            Text(content)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct SlidingPagesView_Previews: PreviewProvider {
    static var previews: some View {
        SlidingPagesView()
    }
}
