
import SwiftUI

struct StartingPage: View {
    @EnvironmentObject var viewModel: GameViewModel
    @State var showOpeningScene: Bool = false
    var body: some View {
        
        ZStack {
            if !showOpeningScene{
                GifWebView(gifName: "StarryBackground")
                // .ignoresSafeArea()
                    .accessibilityElement()
                    .accessibilityLabel("A dark background")
                    .accessibilityHint("A pitch-black background with scattered glowing dots resembling twinkling stars, varying in brightness. Moving meteors streak through the scene like threads of light, adding motion and life to the vast, enchanting universe")
                Button(action: {
                    showOpeningScene = true
                }) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.orange)
                        .shadow(color: .orange, radius: 20, x: 0, y: 0)
                        .padding()
                        .background(
                            Circle()
                                .fill(Color.orange.opacity(0.09))
                                .shadow(radius: 10)
                        )
                }
                .padding(.bottom, 50)
                .padding(.top, 200)
            }else if showOpeningScene{
                OpeningScene()
            }
        }
        
    }
}

#Preview {
    StartingPage()
}
