import SwiftUI

public protocol SelectionMenuBody<Value> {
    associatedtype Value

    func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement
}

public struct SelectionMenuBodyNotSupported<Value>: SelectionMenuBody {
    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        fatalError()
    }
}
