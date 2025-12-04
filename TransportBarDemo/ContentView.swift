import AVFoundation
import Player
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
    )

    var body: some View {
        PlayerView(player: player)
            .transportBar {
                Action(title: "Circler", image: UIImage(systemName: "circle")!) {
                    print("--> circle")
                }
            }
            .ignoresSafeArea()
            .onAppear(perform: player.play)
    }
}

#Preview {
    ContentView()
}
