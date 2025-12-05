import UIKit

public struct SectionContent {
    private let children: [SectionElement]

    init(children: [SectionElement] = []) {
        self.children = children
    }

    func toMenuElements() -> [UIMenuElement] {
        children.map { $0.toMenuElement() }
    }
}
