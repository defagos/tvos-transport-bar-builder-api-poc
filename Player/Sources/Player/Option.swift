import SwiftUI

public struct Option<Body, Value> {
    public let body: Body
}

// MARK: `Menu` embedding

extension Option: MenuElement where Body == MenuBodyNotSupported {
    @available(*, unavailable, message: "Options cannot be used in menus. Use a `SelectionMenu` instead")
    public init(title: String, image: UIImage? = nil, value: Value, handler: @escaping (Value) -> Void = { _ in }) {
        fatalError()
    }
}

// MARK: `Section` embedding

extension Option: SectionElement where Body == SectionBodyNotSupported {
    @available(*, unavailable, message: "Options cannot be used in sections not belonging to a `SelectionMenu`")
    public init(title: String, image: UIImage? = nil, value: Value, handler: @escaping (Value) -> Void = { _ in }) {
        fatalError()
    }
}

// MARK: `SelectionMenu` embedding

public struct OptionInSelectionMenu<Value>: SelectionMenuBody where Value: Equatable {
    let title: String
    let image: UIImage?
    let value: Value
    let handler: (Value) -> Void

    private func state(selection: Binding<Value>) -> UIMenuElement.State {
        selection.wrappedValue == value ? .on : .off
    }

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        // TODO: If possible, should alter selection of other buttons, possibly via publisher and UIAction subclass/wrapper? Currently
        //       we can see two entries marked when selecting another item. Would also prevent direct UIMenuElement creation
        UIAction(title: title, image: image, state: state(selection: selection)) { action in
            selection.wrappedValue = value
            action.state = state(selection: selection)
            handler(value)
        }
    }
}

extension Option: SelectionMenuElement where Body == OptionInSelectionMenu<Value> {
    public init(title: String, image: UIImage? = nil, value: Value, handler: @escaping (Value) -> Void = { _ in }) {
        self.body = .init(title: title, image: image, value: value, handler: handler)
    }
}

// MARK: `SelectionSection` embedding

public struct OptionInSelectionSection<Value>: SelectionSectionBody where Value: Equatable {
    let title: String
    let image: UIImage?
    let value: Value
    let handler: (Value) -> Void

    private func state(selection: Binding<Value>) -> UIMenuElement.State {
        selection.wrappedValue == value ? .on : .off
    }

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        // TODO: If possible, should alter selection of other buttons, possibly via publisher and UIAction subclass/wrapper? Currently
        //       we can see two entries marked when selecting another item. Would also prevent direct UIMenuElement creation
        UIAction(title: title, image: image, state: state(selection: selection)) { action in
            selection.wrappedValue = value
            action.state = state(selection: selection)
            handler(value)
        }
    }
}

extension Option: SelectionSectionElement where Body == OptionInSelectionSection<Value> {
    public init(title: String, image: UIImage? = nil, value: Value, handler: @escaping (Value) -> Void = { _ in }) {
        self.body = .init(title: title, image: image, value: value, handler: handler)
    }
}

// MARK: `TransportBar` embedding

extension Option: TransportBarElement where Body == TransportBarBodyNotSupported {
    @available(*, unavailable, message: "Options cannot be displayed at the transport bar root level")
    public init(title: String, image: UIImage? = nil, value: Value, handler: @escaping (Value) -> Void = { _ in }) {
        fatalError()
    }
}
