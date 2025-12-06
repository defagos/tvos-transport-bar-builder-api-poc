import AVFoundation
import Player
import SwiftUI

enum Quality {
    case low
    case medium
    case high
    case ultraHigh
    case lossless
}

enum GameMode {
    case lowPower
    case normal
}

enum SleepInterval {
    case `10minutes`
    case `30minutes`
    case `60minutes`
}

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
    )
    @State private var isLooping = false
    @State private var isAutoplayEnabled = false
    @State private var isMicrophoneEnabled = false
    @State private var areHeadphonesEnabled = false

    @State private var quality: Quality = .medium
    @State private var gameMode: GameMode = .normal

    @State private var isSleepModeEnabled = false
    @State private var isEnergySavingModeEnabled = false

    @State private var sleepInterval: SleepInterval = .`30minutes`

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
                    Menu(title: "RB", image: UIImage(systemName: "button.roundedbottom.horizontal")!) {
                        Action(title: "R2", image: UIImage(systemName: "r2.button.roundedtop.horizontal")!) {
                            print("--> R2")
                        }
                        Action(title: "R1", image: UIImage(systemName: "r1.button.roundedbottom.horizontal")!) {
                            print("--> R1")
                        }
                    }
                    Picker(title: "Game mode", image: UIImage(systemName: "gamecontroller")!, selection: $gameMode) {
                        Option(title: "Low power", value: .lowPower) { value in
                            print("--> Select \(value)")
                        }
                        Option(title: "Normal", value: .normal) { value in
                            print("--> Select \(value)")
                        }
                    }
                }
                Menu(title: "Xbox", image: UIImage(systemName: "xbox.logo")!) {
                    Section(title: "Front buttons") {
                        Action(title: "X") {
                            print("--> X")
                        }
                        Action(title: "Y") {
                            print("--> X")
                        }
                        Action(title: "A") {
                            print("--> A")
                        }
                        Action(title: "B") {
                            print("--> B")
                        }
                    }
                    Section(title: "Hardware") {
                        Toggle(title: "Sleep mode", image: UIImage(systemName: "powersleep")!, isOn: $isSleepModeEnabled) { isOn in
                            print("--> sleep mode: \(isOn)")
                        }
                        if isSleepModeEnabled {
                            Picker(title: "Sleep after...", image: UIImage(systemName: "zzz")!, selection: $sleepInterval) {
                                Option(title: "10 minutes", value: .`10minutes`) { value in
                                    print("--> Select \(value)")
                                }
                                Option(title: "30 minutes", value: .`30minutes`) { value in
                                    print("--> Select \(value)")
                                }
                                Option(title: "60 minutes", value: .`60minutes`) { value in
                                    print("--> Select \(value)")
                                }
                            }
                        }
                        Toggle(title: "Energy-saving mode", image: UIImage(systemName: "battery.50percent")!, isOn: $isEnergySavingModeEnabled) { isOn in
                            print("--> energy-saving mode: \(isOn)")
                        }
                        Menu(title: "Start") {
                            Action(title: "Restart") {
                                print("--> restart")
                            }
                            Action(title: "Shutdown") {
                                print("--> shutdown")
                            }
                        }
                    }
                }
                Picker(title: "Quality", image: UIImage(systemName: "person.and.background.dotted")!, selection: $quality) {
                    Option(title: "Low", value: .low) { value in
                        print("--> Select \(value)")
                    }
                    Option(title: "Medium", value: .medium) { value in
                        print("--> Select \(value)")
                    }
                    Option(title: "High", value: .high) { value in
                        print("--> Select \(value)")
                    }
                    Section(title: "Fiber Networks") {
                        Option(title: "Ultra-High", value: .ultraHigh) { value in
                            print("--> Select \(value)")
                        }
                        Option(title: "Lossless", value: .lossless) { value in
                            print("--> Select \(value)")
                        }
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
