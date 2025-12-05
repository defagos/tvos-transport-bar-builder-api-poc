import SwiftUI

public struct Toggle<Body, Value> {
    public let body: Body
}

// MARK: `Menu` embedding

public struct ToggleInMenu: MenuBody {
    let title: String
    let image: UIImage?
    let isOn: Binding<Bool>
    let handler: (Bool) -> Void

    private func state(isOn: Binding<Bool>) -> UIMenuElement.State {
        isOn.wrappedValue ? .on : .off
    }

    public func toMenuElement() -> UIMenuElement {
        UIAction(title: title, image: image, identifier: .init(title), state: state(isOn: isOn)) { action in
            isOn.wrappedValue.toggle()
            action.state = state(isOn: isOn)
            handler(isOn.wrappedValue)
        }
    }
}

extension Toggle: MenuElement where Body == ToggleInMenu, Value == Never {
    public init(title: String, image: UIImage? = nil, isOn: Binding<Bool>, handler: @escaping (Bool) -> Void = { _ in }) {
        self.body = .init(title: title, image: image, isOn: isOn, handler: handler)
    }
}

// MARK: `Section` embedding

public struct ToggleInSection: SectionBody {
    let title: String
    let image: UIImage?
    let isOn: Binding<Bool>
    let handler: (Bool) -> Void

    public func toMenuElement() -> UIMenuElement {
        let action = UIAction(title: title, image: image, identifier: .init(title)) { action in
            isOn.wrappedValue.toggle()
            action.state = isOn.wrappedValue ? .on : .off
            handler(isOn.wrappedValue)
        }
        action.state = isOn.wrappedValue ? .on : .off
        return action
    }
}

extension Toggle: SectionElement where Body == ToggleInSection, Value == Never {
    public init(title: String, image: UIImage? = nil, isOn: Binding<Bool>, handler: @escaping (Bool) -> Void = { _ in }) {
        self.body = .init(title: title, image: image, isOn: isOn, handler: handler)
    }
}

// MARK: `SelectionMenu` embedding

extension Toggle: SelectionMenuElement where Body == SelectionMenuBodyNotSupported<Value> {
    @available(*, unavailable, message: "Toggles are not supported in selection menus")
    public init(title: String, image: UIImage? = nil, isOn: Binding<Bool>, handler: @escaping (Bool) -> Void = { _ in }) {
        fatalError()
    }

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        fatalError()
    }
}

// MARK: `SelectionSection` embedding

extension Toggle: SelectionSectionElement where Body == SelectionSectionBodyNotSupported<Value> {
    @available(*, unavailable, message: "Toggles are not supported in selection menu sections")
    public init(title: String, image: UIImage? = nil, isOn: Binding<Bool>, handler: @escaping (Bool) -> Void = { _ in }) {
        fatalError()
    }

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        fatalError()
    }
}

// MARK: `TransportBar` embedding

public struct ToggleInTransportBar: TransportBarBody {
    let title: String
    let image: UIImage
    let isOn: Binding<Bool>
    let handler: (Bool) -> Void

    public func toMenuElement() -> UIMenuElement {
        let action = UIAction(title: title, image: image, identifier: .init(title)) { action in
            isOn.wrappedValue.toggle()
            action.state = isOn.wrappedValue ? .on : .off
            handler(isOn.wrappedValue)
        }
        action.state = isOn.wrappedValue ? .on : .off
        return action
    }
}

extension Toggle: TransportBarElement where Body == ToggleInTransportBar, Value == Never {
    public init(title: String, image: UIImage, isOn: Binding<Bool>, handler: @escaping (Bool) -> Void = { _ in }) {
        self.body = .init(title: title, image: image, isOn: isOn, handler: handler)
    }

    @available(*, unavailable, message: "Elements displayed at the transport bar root level require an associated image")
    public init(title: String, isOn: Binding<Bool>, handler: @escaping (Bool) -> Void = { _ in }) {
        fatalError()
    }
}
