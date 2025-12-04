import SwiftUI

public struct BoundMenuContent<Value> {
    private let children: [BoundMenuElementConvertible<Value>]

    init(children: [BoundMenuElementConvertible<Value>]) {
        self.children = children
    }

    func toMenuElements(selection: Binding<Value>) -> [UIMenuElement] {
        children.map { $0.toMenuElement(selection: selection) }
    }
}
