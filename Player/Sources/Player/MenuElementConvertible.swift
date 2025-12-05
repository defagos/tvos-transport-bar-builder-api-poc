import SwiftUI

public protocol MenuElementConvertible {
    func toMenuElement() -> UIMenuElement
}

public protocol MenuElement: MenuElementConvertible {}
public protocol SectionElement: MenuElementConvertible {}
public protocol TransportBarElement: MenuElementConvertible {}

public struct MenuElementNotSupported: MenuElementConvertible {
    public func toMenuElement() -> UIMenuElement {
        fatalError()
    }
}
