import SwiftUI

public protocol MenuElementConvertible {
    func toMenuElement() -> UIMenuElement
}

public protocol BoundMenuElementConvertible<Value> {
    associatedtype Value

    func toMenuElement(selection: Binding<Value>) -> UIMenuElement
}

public protocol MenuElement: MenuElementConvertible {}
public protocol SelectionMenuElement<Value>: BoundMenuElementConvertible {}
public protocol TransportBarElement: MenuElementConvertible {}
