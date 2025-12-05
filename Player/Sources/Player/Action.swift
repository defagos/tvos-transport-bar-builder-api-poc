import SwiftUI

public struct Action<Body, Value> {
    public let body: Body
}

// MARK: `Menu` embedding

public struct ActionInMenu: MenuBody {
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
}

// MARK: `Section` embedding

public struct ActionInSection: SectionBody {
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
}

// MARK: `SelectionMenu` embedding

extension Action: SelectionMenuElement where Body == SelectionMenuBodyNotSupported<Value> {
    @available(*, unavailable, message: "Actions are not supported in selection menus")
    public init(title: String, image: UIImage? = nil, handler: @escaping (Value) -> Void = { _ in }) {
        fatalError()
    }
}

// MARK: `SelectionSection` embedding

extension Action: SelectionSectionElement where Body == SelectionSectionBodyNotSupported<Value> {
    @available(*, unavailable, message: "Actions are not supported in selection menu sections")
    public init(title: String, image: UIImage? = nil, handler: @escaping (Value) -> Void = { _ in }) {
        fatalError()
    }
}

// MARK: `TransportBar` embedding

public struct ActionInTransportBar: TransportBarBody {
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
}
