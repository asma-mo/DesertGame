import SwiftUI

struct Game: View {
    @EnvironmentObject var viewModel: GameViewModel
    @State private var showHomePage = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            if !showHomePage {
                if !viewModel.gameOver {
                    if viewModel.gameEnds {
                        FullScreenVideoPlayer(
                            videoName: "ending",
                            videoExtension: "MOV",
                            isVideoEnded: $showHomePage
                        )
                        .ignoresSafeArea()
                        

                    }
               
                } else {
                    VStack {
                        Spacer().frame(height: 30)
                        
                        Text("اركض اسرع المرة الجايه ...")
                            .foregroundColor(.white)
                            .italic()
                        
                        Spacer().frame(height: 30)
                        
                        Button(action: {
                            // Restart the game
                            viewModel.gameOver = false
                            viewModel.restartGame(backgroundSound: "full-background.mp3")
                        }) {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                Text("العب مرة ثانية")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.09))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottom
                        )
                    }
                    .padding(40)
                    .frame(maxWidth: 400)
                    .background(
                        Image("gameOver")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .stroke(myColors.darkNavy.opacity(0.8), lineWidth: 2)
                    )
                    .shadow(radius: 15)
                    .scaleEffect(1.1)
                    .transition(.opacity.combined(with: .scale))
                    .animation(.spring())
                }

            // 2) If `showHomePage == true`, that means final video ended; go to home
            } else {
                StartingPage()
            }
        }
        // 3) Let user swipe left/right to move lanes
        .gesture(
            DragGesture()
                .onEnded { value in
                    let horizontalDistance = value.translation.width
                    if horizontalDistance < -50 {
                        viewModel.handleSwipe(direction: .left)
                    } else if horizontalDistance > 50 {
                        viewModel.handleSwipe(direction: .right)
                    }
                }
        )
    }
}
