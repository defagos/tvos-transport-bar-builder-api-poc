import SwiftUI

public protocol MenuElementConvertible {
    func toMenuElement() -> UIMenuElement
}

// TODO: Rename. Applies to children of a view that has a selection, so maybe there is a better concept here
public protocol BoundMenuElementConvertible<Value> {
    associatedtype Value

    func toMenuElement(selection: Binding<Value>) -> UIMenuElement
}

public protocol MenuElement: MenuElementConvertible {}
public protocol SelectionMenuElement<Value>: BoundMenuElementConvertible {}
public protocol TransportBarElement: MenuElementConvertible {}
