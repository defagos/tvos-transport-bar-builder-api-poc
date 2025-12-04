import SwiftUI

public struct Option<Body, Value /* from parent */> {
    private let body: Body
}

extension Option: BoundMenuElementConvertible where Body: BoundMenuElementConvertible<Value> {
    public func toMenuElement(selection: Binding<Value>) -> UIMenuElement {
        body.toMenuElement(selection: selection)
    }
}

public struct OptionInSelectionMenu<Value>: BoundMenuElementConvertible where Value: Equatable {
    let title: String
    let image: UIImage?
    let value: Value
    let handler: () -> Void

    private func state(selection: Binding<Value>) -> UIMenuElement.State {
        selection.wrappedValue == value ? .on : .off
    }

    public func toMenuElement(selection: Binding<Value>) -> UIMenuElement {
        UIAction(title: title, image: image, state: state(selection: selection)) { action in
            selection.wrappedValue = value
            action.state = state(selection: selection)
            handler()
        }
    }
}

extension Option: SelectionMenuElement where Body == OptionInSelectionMenu<Value> {
    public init(title: String, image: UIImage? = nil, value: Value, handler: @escaping () -> Void = {}) {
        self.body = .init(title: title, image: image, value: value, handler: handler)
    }
}
