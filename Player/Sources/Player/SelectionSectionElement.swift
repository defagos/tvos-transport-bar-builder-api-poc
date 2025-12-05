import SwiftUI

public protocol SelectionSectionElement<Value> {
    associatedtype Body: SelectionSectionBody<Value>
    associatedtype Value

    var body: Body { get }
}

extension SelectionSectionElement {
    func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        body.toMenuElement(updating: selection)
    }
}
