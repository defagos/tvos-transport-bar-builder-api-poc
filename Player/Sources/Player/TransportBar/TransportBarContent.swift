import UIKit

public struct TransportBarContent {
    private let children: [TransportBarElement]

    init(children: [TransportBarElement] = []) {
        self.children = children
    }

    func toMenuElements() -> [UIMenuElement] {
        children.map { $0.toMenuElement() }
    }
}
