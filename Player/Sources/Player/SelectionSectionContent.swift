import SwiftUI

public struct SelectionSectionContent<Value> {
    private let children: [SelectionSectionElement<Value>]

    init(children: [SelectionSectionElement<Value>] = []) {
        self.children = children
    }

    func toMenuElements(updating selection: Binding<Value>) -> [UIMenuElement] {
        children.map { $0.toMenuElement(updating: selection) }
    }
}
