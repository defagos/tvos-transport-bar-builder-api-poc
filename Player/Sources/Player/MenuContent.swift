import UIKit

public struct MenuContent {
    private let children: [MenuElementConvertible]

    init(children: [MenuElementConvertible] = []) {
        self.children = children
    }

    func toMenuElements() -> [UIMenuElement] {
        children.map { $0.toMenuElement() }
    }
}
