import SwiftUI

@main
struct DesertGameApp: App {
    @StateObject var gameViewModel = GameViewModel(gameDuration: 20, gameMode: .game)
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(gameViewModel)
                .preferredColorScheme(.dark)
        }
    }
}
