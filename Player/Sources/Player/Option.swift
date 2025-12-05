import SwiftUI

public struct Option<Body, Value> {
    private let body: Body
}

extension Option: SelectionMenuElementConvertible where Body: SelectionMenuElementConvertible<Value> {
    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        body.toMenuElement(updating: selection)
    }
}

public struct OptionInSelectionMenu<Value>: SelectionMenuElementConvertible where Value: Equatable {
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

// Non-supported embeddings below this line

extension Option: MenuElementConvertible where Body == MenuElementNotSupported {
    public func toMenuElement() -> UIMenuElement {
        fatalError()
    }
}

extension Option: MenuElement, TransportBarElement where Body == MenuElementNotSupported {
    @available(*, unavailable, message: "Options require a selection menu`")
    public init(title: String, image: UIImage? = nil, value: Value, handler: @escaping (Value) -> Void = { _ in }) {
        fatalError()
    }
}
