import UIKit

public struct MenuContent {
    private let children: [MenuElement]

    init(children: [MenuElement] = []) {
        self.children = children
    }

    func toMenuElements() -> [UIMenuElement] {
        children.map { $0.toMenuElement() }
    }
}
