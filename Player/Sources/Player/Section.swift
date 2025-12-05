import SwiftUI

public struct Section<Body, Value> {
    private let body: Body
}

extension Section: MenuElementConvertible where Body: MenuElementConvertible {
    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct SectionInMenu: MenuElementConvertible {
    let title: String?
    let content: MenuContent

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title ?? "", options: [.displayInline], children: content.toMenuElements())
    }
}

extension Section: MenuElement where Body == SectionInMenu, Value == Never {
    public init(title: String? = nil, @SectionContentBuilder content: () -> MenuContent) {
        self.body = .init(title: title, content: content())
    }
}

extension Section: SelectionMenuElementConvertible where Body: SelectionMenuElementConvertible<Value> {
    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        body.toMenuElement(updating: selection)
    }
}

public struct SectionInSelectionMenu<Value>: SelectionMenuElementConvertible {
    let title: String?
    let content: SelectionMenuContent<Value>

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        UIMenu(title: title ?? "", options: [.displayInline], children: content.toMenuElements(updating: selection))
    }
}

extension Section: SelectionMenuElement where Body == SectionInSelectionMenu<Value> {
    public init(title: String? = nil, @SelectionSectionContentBuilder<Value> content: () -> SelectionMenuContent<Value>) {
        self.body = .init(title: title, content: content())
    }
}

// Non-supported embeddings below this line

extension Section: SectionElement, TransportBarElement where Body == MenuElementNotSupported, Value == Never {
    @available(*, unavailable, message: "Sections are not supported here")
    public init(title: String? = nil, @SectionContentBuilder content: () -> MenuContent) {
        fatalError()
    }
}

extension Section: SelectionSectionElement where Body == SelectionMenuElementNotSupported<Value> {
    @available(*, unavailable, message: "Sections are not supported here")
    public init(title: String? = nil, @SectionContentBuilder content: () -> MenuContent) {
        fatalError()
    }
}
