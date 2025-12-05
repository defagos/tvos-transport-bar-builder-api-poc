import SwiftUI

public struct Menu<Body, Value> {
    public let body: Body
}

public struct MenuInMenu: MenuBody {
    let title: String
    let image: UIImage?
    let content: MenuContent

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, children: content.toMenuElements())
    }
}

extension Menu: MenuElement where Body == MenuInMenu, Value == Never {
    public init(title: String, image: UIImage? = nil, @MenuContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, image: image, content: content())
    }
}

public struct MenuInSection: SectionBody {
    let title: String
    let image: UIImage?
    let content: MenuContent

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, children: content.toMenuElements())
    }
}

extension Menu: SectionElement where Body == MenuInSection, Value == Never {
    public init(title: String, image: UIImage? = nil, @MenuContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, image: image, content: content())
    }
}

public struct MenuInTransportBar: TransportBarBody {
    let title: String
    let image: UIImage
    let content: MenuContent

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, children: content.toMenuElements())
    }
}

extension Menu: TransportBarElement where Body == MenuInTransportBar, Value == Never {
    public init(title: String, image: UIImage, @MenuContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, image: image, content: content())
    }
}

// Non-supported embeddings below this line

extension Menu: SelectionMenuElement where Body == SelectionMenuBodyNotSupported<Value> {
    @available(*, unavailable, message: "Menus are not supported here")
    public init(title: String, image: UIImage? = nil, @MenuContentBuilder content: () -> MenuContent) {
        fatalError()
    }
}
