import SwiftUI

public struct SelectionMenuContent<Value> {
    private let children: [SelectionMenuElementConvertible<Value>]

    init(children: [SelectionMenuElementConvertible<Value>] = []) {
        self.children = children
    }

    func toMenuElements(updating selection: Binding<Value>) -> [UIMenuElement] {
        children.map { $0.toMenuElement(updating: selection) }
    }
}
