import SwiftUI

public struct SelectionMenu<Body, Value> {
    private let body: Body
}

extension SelectionMenu: MenuElementConvertible where Body: MenuElementConvertible {
    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct SelectionMenuInMenu<Value>: MenuElementConvertible {
    let title: String
    let image: UIImage?
    let selection: Binding<Value>
    let content: SelectionMenuContent<Value>

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, options: [.singleSelection], children: content.toMenuElements(updating: selection))
    }
}

extension SelectionMenu: MenuElement where Body == SelectionMenuInMenu<Value> {
    public init(
        title: String,
        image: UIImage? = nil,
        selection: Binding<Value>,
        @SelectionMenuContentBuilder<Value> content: () -> SelectionMenuContent<Value>
    ) {
        self.body = .init(title: title, image: image, selection: selection, content: content())
    }
}

public struct SelectionMenuInSection<Value>: MenuElementConvertible {
    let title: String
    let image: UIImage?
    let selection: Binding<Value>
    let content: SelectionMenuContent<Value>

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, options: [.singleSelection], children: content.toMenuElements(updating: selection))
    }
}

extension SelectionMenu: SectionElement where Body == SelectionMenuInSection<Value> {
    public init(
        title: String,
        image: UIImage? = nil,
        selection: Binding<Value>,
        @SelectionMenuContentBuilder<Value> content: () -> SelectionMenuContent<Value>
    ) {
        self.body = .init(title: title, image: image, selection: selection, content: content())
    }
}

public struct SelectionMenuInSelectionMenu<Value>: SelectionMenuElementConvertible {
    let title: String
    let image: UIImage?
    let content: SelectionMenuContent<Value>

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        UIMenu(title: title, image: image, options: [.singleSelection], children: content.toMenuElements(updating: selection))
    }
}

extension SelectionMenu: SelectionMenuElementConvertible where Body == SelectionMenuInSelectionMenu<Value> {
    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        body.toMenuElement(updating: selection)
    }
}

extension SelectionMenu: SelectionMenuElement where Body == SelectionMenuInSelectionMenu<Value> {
    public init(title: String, image: UIImage? = nil, @SelectionMenuContentBuilder<Value> content: () -> SelectionMenuContent<Value>) {
        self.body = .init(title: title, image: image, content: content())
    }

    @available(*, unavailable, message: "Nested selection menus with different selections are not supported. Remove the `selection` parameter")
    public init(title: String, image: UIImage? = nil, selection: Binding<Value>, @SelectionMenuContentBuilder<Value> content: () -> SelectionMenuContent<Value>) {
        fatalError()
    }
}

public struct SelectionMenuInTransportBar<Value>: MenuElementConvertible {
    let title: String
    let image: UIImage
    let selection: Binding<Value>
    let content: SelectionMenuContent<Value>

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, options: [.singleSelection], children: content.toMenuElements(updating: selection))
    }
}

extension SelectionMenu: TransportBarElement where Body == SelectionMenuInTransportBar<Value> {
    public init(title: String, image: UIImage, selection: Binding<Value>, @SelectionMenuContentBuilder<Value> content: () -> SelectionMenuContent<Value>) {
        self.body = .init(title: title, image: image, selection: selection, content: content())
    }
}
