import SwiftUI

struct GameOver: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
            if viewModel.gameOver {
                VStack {
                    Spacer().frame(height: 30)
                    
                    // Game Over Text with VoiceOver Customization
                    Text("اركض اسرع المرة الجايه ...")
                        .foregroundColor(.white)
                        .italic()
                        .accessibilityElement(children: .combine)  // Combines the Text as one readable element
                        .accessibilityLabel("لقد خسرت الجولة، حاول الركض أسرع في المرة القادمة.")  // Custom message
                    
                    Spacer().frame(height: 30)
                    
                    // Restart Button with Custom Label
                    Button(action: {
                        viewModel.gameOver = false
                        viewModel.restartGame(backgroundSound: "full-background.mp3")
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .accessibilityHidden(true)  // Prevent VoiceOver from reading icon separately
                            
                            Text("العب مرة ثانية")
                                .accessibilityLabel("إعادة المحاولة")  // Custom VoiceOver label for button
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.09))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .accessibilityElement(children: .combine)  // Combine button text and icon as one element
                    .accessibilityHint("اضغط لإعادة اللعب من جديد")  // Add hint for context
                    
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottom
                    )
                }
                .padding(40)
                .frame(maxWidth: 400)
                
                // Background Image – Hidden from VoiceOver
                .background(
                    Image("gameOver")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .accessibilityHidden(true)  // Decorative image, no need for VoiceOver
                )
                
                // Overlay with Rounded Rectangle
                .overlay(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .stroke(myColors.darkNavy.opacity(0.8), lineWidth: 2)
                        .accessibilityHidden(true)  // Hide overlay from VoiceOver
                )
                
                .shadow(radius: 15)
                .scaleEffect(1.1)
                .transition(.opacity.combined(with: .scale))
                .animation(.spring())
                .accessibilityElement(children: .contain)
                .accessibilityLabel("خسرت اللعبة")  // Custom message for entire VStack
                
            } else {
                // Main Game View if game is not over
                Game()
                    .environmentObject(viewModel)
                    .onAppear {
                        // Switch game mode when appearing
                        viewModel.switchMode(
                            to: .game,
                            duration: 88,
                            backgroundSound: "full-background.mp3"
                        )
                    }
                    .accessibilityLabel("اللعبة مستمرة")
            }
        }
    
}

// Preview
#Preview {
    GameOver()
}
