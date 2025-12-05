import SwiftUI

public protocol SelectionMenuElement<Value> {
    associatedtype Value

    func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement
}

public protocol SelectionSectionElement<Value> {
    associatedtype Value

    func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement
}

public struct SelectionMenuElementNotSupported<Value>: SelectionMenuElement {
    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        fatalError()
    }
}

public struct SelectionSectionElementNotSupported<Value>: SelectionSectionElement {
    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        fatalError()
    }
}
