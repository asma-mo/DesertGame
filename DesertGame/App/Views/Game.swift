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
                    GameOver()
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
