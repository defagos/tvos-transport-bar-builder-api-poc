import AVKit
import SwiftUI

public struct PlayerView: UIViewControllerRepresentable {
    private let player: AVPlayer
    private var transportBarContent = TransportBarContent()

    public init(player: AVPlayer) {
        self.player = player
    }

    public func makeUIViewController(context: Context) -> AVPlayerViewController {
        AVPlayerViewController()
    }

    public func updateUIViewController(_ playerViewController: AVPlayerViewController, context: Context) {
        playerViewController.player = player
        playerViewController.transportBarCustomMenuItems = transportBarContent.toMenuElements()
    }
}

public extension PlayerView {
    func transportBar(@TransportBarContentBuilder content: () -> TransportBarContent) -> Self {
        var view = self
        view.transportBarContent = content()
        return view
    }
}
