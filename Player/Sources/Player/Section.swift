import SwiftUI

public struct Section<Body, Value> {
    public let body: Body
}

public struct SectionInMenu: MenuBody {
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
}

public struct SectionInSelectionMenu<Value>: SelectionMenuBody {
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
}

extension Section: SectionElement where Body == SectionBodyNotSupported, Value == Never {
    @available(*, unavailable, message: "Nested sections are not supported")
    public init(title: String? = nil, @SectionContentBuilder content: () -> SectionContent) {
        fatalError()
    }
}

extension Section: TransportBarElement where Body == TransportBarBodyNotSupported, Value == Never {
    @available(*, unavailable, message: "Sections cannot be displayed at the transport bar level")
    public init(title: String? = nil, @SectionContentBuilder content: () -> SectionContent) {
        fatalError()
    }
}

extension Section: SelectionSectionElement where Body == SelectionSectionBodyNotSupported<Value> {
    @available(*, unavailable, message: "Nested sections are not supported")
    public init(title: String? = nil, @SectionContentBuilder content: () -> SectionContent) {
        fatalError()
    }
}
