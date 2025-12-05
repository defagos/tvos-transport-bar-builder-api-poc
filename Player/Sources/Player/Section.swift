import SwiftUI

public struct Section<Body, Value> {
    private let body: Body
}

public struct SectionInMenu: MenuElement {
    let title: String?
    let content: SectionContent

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title ?? "", options: [.displayInline], children: content.toMenuElements())
    }
}

extension Section: MenuElement where Body == SectionInMenu, Value == Never {
    public init(title: String? = nil, @SectionContentBuilder content: () -> SectionContent) {
        self.body = .init(title: title, content: content())
    }

    public func toMenuElement() -> UIMenuElement {
        body.toMenuElement()
    }
}

public struct SectionInSelectionMenu<Value>: SelectionMenuElement {
    let title: String?
    let content: SelectionSectionContent<Value>

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        UIMenu(title: title ?? "", options: [.displayInline], children: content.toMenuElements(updating: selection))
    }
}

extension Section: SelectionMenuElement where Body == SectionInSelectionMenu<Value> {
    public init(title: String? = nil, @SelectionSectionContentBuilder<Value> content: () -> SelectionSectionContent<Value>) {
        self.body = .init(title: title, content: content())
    }

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        body.toMenuElement(updating: selection)
    }
}

// Non-supported embeddings below this line

extension Section: SectionElement where Body == SectionElementNotSupported, Value == Never {
    @available(*, unavailable, message: "Nested sections are not supported")
    public init(title: String? = nil, @SectionContentBuilder content: () -> SectionContent) {
        fatalError()
    }

    public func toMenuElement() -> UIMenuElement {
        fatalError()
    }
}

extension Section: TransportBarElement where Body == TransportBarElementNotSupported, Value == Never {
    @available(*, unavailable, message: "Sections cannot be displayed at the transport bar level")
    public init(title: String? = nil, @SectionContentBuilder content: () -> SectionContent) {
        fatalError()
    }

    public func toMenuElement() -> UIMenuElement {
        fatalError()
    }
}

extension Section: SelectionSectionElement where Body == SelectionSectionElementNotSupported<Value> {
    @available(*, unavailable, message: "Nested sections are not supported")
    public init(title: String? = nil, @SectionContentBuilder content: () -> SectionContent) {
        fatalError()
    }

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        fatalError()
    }
}
