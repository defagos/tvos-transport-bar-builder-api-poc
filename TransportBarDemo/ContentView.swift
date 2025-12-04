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
                Toggle(title: "Loop", image: UIImage(systemName: loopingImageName)!, isOn: $isLooping) {
                    print("--> Loop")
                }
                Toggle(title: "Autoplay", image: UIImage(systemName: autoplayImageName)!, isOn: $isAutoplayEnabled) {
                    print("--> Autoplay")
                }
            }
            .ignoresSafeArea()
            .onAppear(perform: player.play)
    }

    private var loopingImageName: String {
        isLooping ? "point.forward.to.point.capsulepath.fill" : "point.forward.to.point.capsulepath"
    }

    private var autoplayImageName: String {
        isAutoplayEnabled ? "play.circle.fill" : "play.circle"
    }
}

#Preview {
    ContentView()
}
