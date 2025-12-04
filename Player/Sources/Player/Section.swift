import UIKit

public struct Section<Body> {
    private let body: Body
}

extension Section: MenuElementConvertible where Body: MenuElementConvertible {
    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct SectionInMenu: MenuElementConvertible {
    let title: String?
    let children: [UIMenuElement]

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title ?? "", options: [.displayInline], children: children)
    }
}

extension Section: MenuElement where Body == SectionInMenu {
    public init(title: String? = nil, @SectionContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, children: content().toMenuElements())
    }
}
