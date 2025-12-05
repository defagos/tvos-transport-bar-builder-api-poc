import SwiftUI

public struct SelectionMenu<Body, Value> {
    private let body: Body
}

public struct SelectionMenuInMenu<Value>: MenuElement {
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

    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct SelectionMenuInSection<Value>: SectionElement {
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

    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct SelectionMenuInSelectionMenu<Value>: SelectionMenuElement {
    let title: String
    let image: UIImage?
    let content: SelectionMenuContent<Value>

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        UIMenu(title: title, image: image, options: [.singleSelection], children: content.toMenuElements(updating: selection))
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

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        body.toMenuElement(updating: selection)
    }
}

public struct SelectionMenuInTransportBar<Value>: TransportBarElement {
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

    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}
