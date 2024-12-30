import SwiftUI
import CoreHaptics

struct GameTutorial: View {
    @EnvironmentObject var viewModel: GameViewModel
    @State private var showGame = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            // 1) If we have NOT switched to Game view yet
            if !showGame {
                // a) Show tutorial arrow prompts if tutorial not complete
                if !viewModel.tutrioalComplete {
                    if viewModel.showLeftArrow {
                        Image("leftArrow")
                            .resizable()
                            .frame(width: 200, height: 120)
                            .offset(x: viewModel.leftArrowOffset)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 1)
                                    .repeatForever(autoreverses: true)) {
                                    viewModel.leftArrowOffset = -30
                                }
                                UIAccessibility.post(
                                    notification: .layoutChanged,
                                    argument: "Swipe left to avoid obstacle"
                                )
                            }
                            .accessibilityLabel("Swipe left to avoid obstacle")
                            .accessibilityAddTraits(.isButton)
                            .transition(.opacity)
                        
                    } else if viewModel.showRightArrow {
                        Image("rightArrow")
                            .resizable()
                            .frame(width: 200, height: 120)
                            .offset(x: viewModel.rightArrowOffset)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 1)
                                    .repeatForever(autoreverses: true)) {
                                    viewModel.rightArrowOffset = -30
                                }
                                UIAccessibility.post(
                                    notification: .layoutChanged,
                                    argument: "Swipe right to avoid obstacle"
                                )
                            }
                            .accessibilityLabel("Swipe right to avoid obstacle")
                            .accessibilityAddTraits(.isButton)
                            .transition(.opacity)
                    }
                    
                // b) If tutorial IS complete, automatically move on to the Game
                } else {
                    Color.clear
                        .onAppear {
                            // Switch to the Game
                            showGame = true
                        }
                }
                
            // 2) If we have switched to Game view
            } else {
                Game()
                    .environmentObject(viewModel)
                    .onAppear {
                        // Switch your game mode, start the timer
                        viewModel.switchMode(
                            to: .game,
                            duration: 88,              // example: 60s game
                            backgroundSound: "full-background.mp3"
                        )
                    }
            }
        }
        // 3) Handle swipes for tutorial
        .simultaneousGesture(
            DragGesture()
                .onEnded { value in
                    let horizontalDistance = value.translation.width
                    if horizontalDistance < -50 {
                        viewModel.handleSwipe(direction: .left)
                        UIAccessibility.post(
                            notification: .layoutChanged,
                            argument: "Swiped left"
                        )
                    } else if horizontalDistance > 50 {
                        viewModel.handleSwipe(direction: .right)
                        UIAccessibility.post(
                            notification: .layoutChanged,
                            argument: "Swiped right"
                        )
                    }
                }
        )
        .accessibilityAction(named: "Swipe Left") {
            viewModel.handleSwipe(direction: .left)
        }
        .accessibilityAction(named: "Swipe Right") {
            viewModel.handleSwipe(direction: .right)
        }
    }
}
