import AVFoundation
import Player
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
    )
    @State private var isLooping = false
    @State private var isAutoplayEnabled = false
    @State private var isMicrophoneEnabled = false
    @State private var areHeadphonesEnabled = false

    var body: some View {
        PlayerView(player: player)
            .transportBar {
                Action(title: "Share", image: UIImage(systemName: "square.and.arrow.up")!) {
                    print("--> share")
                }
                Toggle(title: "Loop", image: UIImage(systemName: loopingImageName)!, isOn: $isLooping) { isOn in
                    print("--> loop: \(isOn)")
                }
                Toggle(title: "Autoplay", image: UIImage(systemName: autoplayImageName)!, isOn: $isAutoplayEnabled) { isOn in
                    print("--> autoplay: \(isOn)")
                }
                Menu(title: "PlayStation", image: UIImage(systemName: "playstation.logo")!) {
                    Action(title: "Cross", image: UIImage(systemName: "xmark")!) {
                        print("--> cross")
                    }
                    Action(title: "Circle", image: UIImage(systemName: "circle")!) {
                        print("--> circle")
                    }
                    Toggle(title: "Microphone", image: UIImage(systemName: "microphone")!, isOn: $isMicrophoneEnabled) { isOn in
                        print("--> microphone: \(isOn)")
                    }
                    Toggle(title: "Headphones", image: UIImage(systemName: "headphones")!, isOn: $areHeadphonesEnabled) { isOn in
                        print("--> headphones: \(isOn)")
                    }
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
