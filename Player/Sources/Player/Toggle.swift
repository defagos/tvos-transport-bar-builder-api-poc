import SwiftUI

public struct Toggle<Body, Value /* attached to the toggle directly */> {
    private let body: Body
}

extension Toggle: MenuElementConvertible where Body: MenuElementConvertible {
    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct ToggleInMenu: MenuElementConvertible {
    let title: String
    let image: UIImage?
    let isOn: Binding<Bool>
    let handler: () -> Void

    public func toMenuElement() -> UIMenuElement {
        let action = UIAction(title: title, image: image) { action in
            isOn.wrappedValue.toggle()
            action.state = isOn.wrappedValue ? .on : .off
            handler()
        }
        action.state = isOn.wrappedValue ? .on : .off
        return action
    }
}

extension Toggle: MenuElement where Body == ToggleInMenu {
    public init(title: String, image: UIImage? = nil, isOn: Binding<Bool>, handler: @escaping () -> Void) {
        self.body = .init(title: title, image: image, isOn: isOn, handler: handler)
    }
}

public struct ToggleInTransportBar: MenuElementConvertible {
    let title: String
    let image: UIImage
    let isOn: Binding<Bool>
    let handler: () -> Void

    public func toMenuElement() -> UIMenuElement {
        let action = UIAction(title: title, image: image) { action in
            isOn.wrappedValue.toggle()
            action.state = isOn.wrappedValue ? .on : .off
            handler()
        }
        action.state = isOn.wrappedValue ? .on : .off
        return action
    }
}

extension Toggle: TransportBarElement where Body == ToggleInTransportBar {
    public init(title: String, image: UIImage, isOn: Binding<Bool>, handler: @escaping () -> Void) {
        self.body = .init(title: title, image: image, isOn: isOn, handler: handler)
    }
}
