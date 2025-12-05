import SwiftUI

public struct Menu<Body, Value> {
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

extension Menu: MenuElement where Body == MenuInMenu, Value == Never {
    public init(title: String, image: UIImage? = nil, @MenuContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, image: image, content: content())
    }
}

public struct MenuInSelection: MenuElementConvertible {
    let title: String
    let image: UIImage?
    let content: MenuContent

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, children: content.toMenuElements())
    }
}

extension Menu: SectionElement where Body == MenuInSelection, Value == Never {
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

extension Menu: TransportBarElement where Body == MenuInTransportBar, Value == Never {
    public init(title: String, image: UIImage, @MenuContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, image: image, content: content())
    }
}

// Non-supported embeddings below this line

extension Menu: SelectionMenuElementConvertible where Body == SelectionMenuElementNotSupported<Value> {
    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        fatalError()
    }
}

extension Menu: SelectionMenuElement where Body == SelectionMenuElementNotSupported<Value> {
    @available(*, unavailable, message: "Menus are not supported here")
    public init(title: String, image: UIImage? = nil, @MenuContentBuilder content: () -> MenuContent) {
        fatalError()
    }
}
