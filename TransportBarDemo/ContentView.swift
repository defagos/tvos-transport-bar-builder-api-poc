import AVFoundation
import Player
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
    )
    @State private var isLooping = false
    @State private var isAutoplayEnabled = false

    var body: some View {
        PlayerView(player: player)
            .transportBar {
                Action(title: "Share", image: UIImage(systemName: "square.and.arrow.up")!) {
                    print("--> Share")
                }
                Toggle(title: "Loop", image: UIImage(systemName: "point.forward.to.point.capsulepath")!, isOn: $isLooping) {
                    print("--> Loop")
                }
            }
            .ignoresSafeArea()
            .onAppear(perform: player.play)
    }
}

#Preview {
    ContentView()
}
