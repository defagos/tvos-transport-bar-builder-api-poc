import SwiftUI

public protocol SelectionMenuElementConvertible<Value> {
    associatedtype Value

    func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement
}

public protocol SelectionMenuElement<Value>: SelectionMenuElementConvertible {}
