import SwiftUI

public protocol SelectionSectionBody<Value> {
    associatedtype Value

    func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement
}

public struct SelectionSectionBodyNotSupported<Value>: SelectionSectionBody {
    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        fatalError()
    }
}
