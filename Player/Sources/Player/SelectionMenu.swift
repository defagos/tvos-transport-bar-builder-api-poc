import SwiftUI

public struct SelectionMenu<Body> {
    private let body: Body
}

extension SelectionMenu: MenuElementConvertible where Body: MenuElementConvertible {
    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct SelectionMenuInMenu: MenuElementConvertible {
    let title: String
    let image: UIImage?
    let children: [UIMenuElement]

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, options: [.singleSelection], children: children)
    }
}

extension SelectionMenu: MenuElement where Body == SelectionMenuInMenu {
    public init<Value>(title: String, image: UIImage? = nil, selection: Binding<Value>, @SelectionMenuContentBuilder<Value> content: () -> BoundMenuContent<Value>) {
        self.body = .init(title: title, image: image, children: content().toMenuElements(updating: selection))
    }
}

public struct SelectionMenuInSection: MenuElementConvertible {
    let title: String
    let image: UIImage?
    let children: [UIMenuElement]

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, options: [.singleSelection], children: children)
    }
}

extension SelectionMenu: SectionElement where Body == SelectionMenuInSection {
    public init<Value>(title: String, image: UIImage? = nil, selection: Binding<Value>, @SelectionMenuContentBuilder<Value> content: () -> BoundMenuContent<Value>) {
        self.body = .init(title: title, image: image, children: content().toMenuElements(updating: selection))
    }
}

public struct SelectionMenuInTransportBar: MenuElementConvertible {
    let title: String
    let image: UIImage
    let children: [UIMenuElement]

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, options: [.singleSelection], children: children)
    }
}

extension SelectionMenu: TransportBarElement where Body == SelectionMenuInTransportBar {
    public init<Value>(title: String, image: UIImage, selection: Binding<Value>, @SelectionMenuContentBuilder<Value> content: () -> BoundMenuContent<Value>) {
        self.body = .init(title: title, image: image, children: content().toMenuElements(updating: selection))
    }
}
