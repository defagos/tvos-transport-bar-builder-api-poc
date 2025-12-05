import SwiftUI

public struct PickerSectionContent<Value> {
    private let children: [PickerSectionElement<Value>]

    init(children: [PickerSectionElement<Value>] = []) {
        self.children = children
    }

    func toMenuElements(updating selection: Binding<Value>) -> [UIMenuElement] {
        children.map { $0.toMenuElement(updating: selection) }
    }
}
