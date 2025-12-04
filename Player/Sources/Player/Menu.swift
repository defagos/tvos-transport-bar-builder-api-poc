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
    let content: MenuContent

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, children: content.toMenuElements())
    }
}

extension Menu: MenuElement where Body == MenuInMenu {
    public init(title: String, image: UIImage? = nil, @MenuContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, image: image, content: content())
    }
}

public struct MenuInTransportBar: MenuElementConvertible {
    let title: String
    let image: UIImage
    let content: MenuContent

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, children: content.toMenuElements())
    }
}

extension Menu: TransportBarElement where Body == MenuInTransportBar {
    public init(title: String, image: UIImage, @MenuContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, image: image, content: content())
    }
}
