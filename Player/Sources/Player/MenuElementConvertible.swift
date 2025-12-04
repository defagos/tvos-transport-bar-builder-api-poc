import SwiftUI

protocol MenuElementConvertible<Value> {
    associatedtype Value

    func toMenuElement(selection: Binding<Value>) -> UIMenuElement
}
