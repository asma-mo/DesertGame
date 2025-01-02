
import SwiftUI
import AVKit


struct OpeningScene: View {
    @EnvironmentObject var viewModel: GameViewModel
    @State var showTutorial: Bool = false

    var body: some View {
        NavigationStack {
            if !showTutorial{
                ZStack {
                    FullScreenVideoPlayer(videoName: "Start", videoExtension: "MOV", isVideoEnded: $showTutorial)
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                showTutorial = true
                            }) {
                                Text("Skip")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .cornerRadius(10)
                                    .padding(10)
                            }
                           
                        }
                    }
                }
              
            }else if showTutorial{
                GameTutorial()
                    .environmentObject(viewModel)
                    .onAppear {
                        viewModel.switchMode(to: .tutorial, duration: 12, backgroundSound: "Tut-bkg.mp3")
                    }
            }
        }
                .navigationBarBackButtonHidden(true)
        }
    
}
#Preview {
    OpeningScene()
}
