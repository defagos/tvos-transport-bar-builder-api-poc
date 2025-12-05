import SwiftUI

public struct Menu<Body, Value> {
    private let body: Body
}

public struct MenuInMenu: MenuElement {
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

    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct MenuInSection: SectionElement {
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

    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct MenuInTransportBar: TransportBarElement {
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

    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

// Non-supported embeddings below this line

extension Menu: SelectionMenuElement where Body == SelectionMenuElementNotSupported<Value> {
    @available(*, unavailable, message: "Menus are not supported here")
    public init(title: String, image: UIImage? = nil, @MenuContentBuilder content: () -> MenuContent) {
        fatalError()
    }

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        fatalError()
    }
}
