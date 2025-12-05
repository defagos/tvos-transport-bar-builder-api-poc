import SwiftUI

public struct Action<Body, Value> {
    private let body: Body
}

public struct ActionInMenu: MenuElement {
    let title: String
    let image: UIImage?
    let handler: () -> Void

    public func toMenuElement() -> UIMenuElement {
        UIAction(title: title, image: image) { _ in handler() }
    }
}

extension Action: MenuElement where Body == ActionInMenu, Value == Never {
    public init(title: String, image: UIImage? = nil, handler: @escaping () -> Void) {
        self.body = .init(title: title, image: image, handler: handler)
    }

    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct ActionInSection: SectionElement {
    let title: String
    let image: UIImage?
    let handler: () -> Void

    public func toMenuElement() -> UIMenuElement {
        UIAction(title: title, image: image) { _ in handler() }
    }
}

extension Action: SectionElement where Body == ActionInSection, Value == Never {
    public init(title: String, image: UIImage? = nil, handler: @escaping () -> Void) {
        self.body = .init(title: title, image: image, handler: handler)
    }

    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct ActionInTransportBar: TransportBarElement {
    let title: String
    let image: UIImage
    let handler: () -> Void

    public func toMenuElement() -> UIMenuElement {
        UIAction(title: title, image: image) { _ in handler() }
    }
}

extension Action: TransportBarElement where Body == ActionInTransportBar, Value == Never {
    public init(title: String, image: UIImage, handler: @escaping () -> Void) {
        self.body = .init(title: title, image: image, handler: handler)
    }

    @available(*, unavailable, message: "Elements displayed at the transport bar level require an associated image")
    public init(title: String, handler: @escaping () -> Void) {
        fatalError()
    }

    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

// Non-supported embeddings below this line

extension Action: SelectionMenuElement where Body == SelectionMenuElementNotSupported<Value> {
    @available(*, unavailable, message: "Actions are not supported here")
    public init(title: String, image: UIImage? = nil, handler: @escaping (Value) -> Void = { _ in }) {
        fatalError()
    }

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        fatalError()
    }
}
