import SwiftUI

public protocol MenuElement {
    func toMenuElement() -> UIMenuElement
}

public protocol SectionElement {
    func toMenuElement() -> UIMenuElement
}

public protocol TransportBarElement {
    func toMenuElement() -> UIMenuElement
}

public struct MenuElementNotSupported: MenuElement {
    public func toMenuElement() -> UIMenuElement {
        fatalError()
    }
}

public struct SectionElementNotSupported: SectionElement {
    public func toMenuElement() -> UIMenuElement {
        fatalError()
    }
}

public struct TransportBarElementNotSupported: TransportBarElement {
    public func toMenuElement() -> UIMenuElement {
        fatalError()
    }
}
