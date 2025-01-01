
import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var viewModel: GameViewModel
    @State private var showStartingPage: Bool = false

    @State private var opacity = 0.0

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                if showStartingPage {
                    StartingPage().environmentObject(viewModel)
                } else if !showStartingPage{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 1000, height: 1000)
                        .opacity(opacity)
                        .padding()
                        .accessibilityElement()
                        .accessibilityLabel("splash screen")
                        .accessibilityHint("person in a desert and SAND SOUND glowing")
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.5)) {
                                opacity = 1.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    showStartingPage = true
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}

