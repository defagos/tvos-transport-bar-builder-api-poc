import UIKit

public struct Menu<Body> {
    private let body: Body
}

extension Menu: MenuElementConvertible where Body: MenuElementConvertible {
    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct MenuInMenu: MenuElementConvertible {
    let title: String
    let image: UIImage?
    let children: [UIMenuElement]

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, children: children)
    }
}

extension Menu: MenuElement where Body == MenuInMenu {
    public init(title: String, image: UIImage? = nil, @MenuContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, image: image, children: content().toMenuElements())
    }
}

public struct MenuInSelection: MenuElementConvertible {
    let title: String
    let image: UIImage?
    let children: [UIMenuElement]

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, children: children)
    }
}

extension Menu: SectionElement where Body == MenuInSelection {
    public init(title: String, image: UIImage? = nil, @MenuContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, image: image, children: content().toMenuElements())
    }
}

public struct MenuInTransportBar: MenuElementConvertible {
    let title: String
    let image: UIImage
    let children: [UIMenuElement]

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, children: children)
    }
}

extension Menu: TransportBarElement where Body == MenuInTransportBar {
    public init(title: String, image: UIImage, @MenuContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, image: image, children: content().toMenuElements())
    }
}
