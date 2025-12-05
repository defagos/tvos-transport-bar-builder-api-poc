import SwiftUI

public protocol SelectionMenuElement<Value> {
    associatedtype Body: SelectionMenuBody<Value>
    associatedtype Value

    var body: Body { get }
}

extension SelectionMenuElement {
    func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        body.toMenuElement(updating: selection)
    }
}
