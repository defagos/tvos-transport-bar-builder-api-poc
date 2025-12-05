import SwiftUI

public struct PickerContent<Value> {
    private let children: [PickerElement<Value>]

    init(children: [PickerElement<Value>] = []) {
        self.children = children
    }

    func toMenuElements(updating selection: Binding<Value>) -> [UIMenuElement] {
        children.map { $0.toMenuElement(updating: selection) }
    }
}
