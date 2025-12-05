import SwiftUI

public protocol SelectionMenuElementConvertible<Value> {
    associatedtype Value

    func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement
}

public protocol SelectionMenuElement<Value>: SelectionMenuElementConvertible {}
public protocol SelectionSectionElement<Value>: SelectionMenuElementConvertible {}

public struct SelectionMenuElementNotSupported<Value>: SelectionMenuElementConvertible {
    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        fatalError()
    }
}
