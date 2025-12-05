import SwiftUI

public struct Picker<Body, Value> {
    public let body: Body
}

// MARK: `Menu` embedding

public struct PickerInMenu<Value>: MenuBody {
    let title: String
    let image: UIImage?
    let selection: Binding<Value>
    let content: PickerContent<Value>

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, identifier: .init(title), options: [.singleSelection], children: content.toMenuElements(updating: selection))
    }
}

extension Picker: MenuElement where Body == PickerInMenu<Value> {
    public init(
        title: String,
        image: UIImage? = nil,
        selection: Binding<Value>,
        @PickerContentBuilder<Value> content: () -> PickerContent<Value>
    ) {
        self.body = .init(title: title, image: image, selection: selection, content: content())
    }
}

// MARK: `Section` embedding

public struct PickerInSection<Value>: SectionBody {
    let title: String
    let image: UIImage?
    let selection: Binding<Value>
    let content: PickerContent<Value>

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, identifier: .init(title), options: [.singleSelection], children: content.toMenuElements(updating: selection))
    }
}

extension Picker: SectionElement where Body == PickerInSection<Value> {
    public init(
        title: String,
        image: UIImage? = nil,
        selection: Binding<Value>,
        @PickerContentBuilder<Value> content: () -> PickerContent<Value>
    ) {
        self.body = .init(title: title, image: image, selection: selection, content: content())
    }
}

// MARK: `Picker` embedding

public struct PickerInPicker<Value>: PickerBody {
    let title: String
    let image: UIImage?
    let content: PickerContent<Value>

    public func toMenuElement(updating selection: Binding<Value>) -> UIMenuElement {
        UIMenu(title: title, image: image, identifier: .init(title), options: [.singleSelection], children: content.toMenuElements(updating: selection))
    }
}

extension Picker: PickerElement where Body == PickerInPicker<Value> {
    public init(title: String, image: UIImage? = nil, @PickerContentBuilder<Value> content: () -> PickerContent<Value>) {
        self.body = .init(title: title, image: image, content: content())
    }

    @available(*, unavailable, message: "Nested pickers with different selections are not supported. Remove the `selection` parameter")
    public init(title: String, image: UIImage? = nil, selection: Binding<Value>, @PickerContentBuilder<Value> content: () -> PickerContent<Value>) {
        fatalError()
    }
}

// MARK: `PickerSection` embedding

extension Picker: PickerSectionElement where Body == PickerSectionBodyNotSupported<Value> {
    @available(*, unavailable, message: "Pickers cannot be nested in picker sections")
    public init(title: String, image: UIImage? = nil, @PickerContentBuilder<Value> content: () -> PickerContent<Value>) {
        fatalError()
    }
}

// MARK: `TransportBar` embedding

public struct PickerInTransportBar<Value>: TransportBarBody {
    let title: String
    let image: UIImage
    let selection: Binding<Value>
    let content: PickerContent<Value>

    public func toMenuElement() -> UIMenuElement {
        UIMenu(title: title, image: image, identifier: .init(title), options: [.singleSelection], children: content.toMenuElements(updating: selection))
    }
}

extension Picker: TransportBarElement where Body == PickerInTransportBar<Value> {
    public init(title: String, image: UIImage, selection: Binding<Value>, @PickerContentBuilder<Value> content: () -> PickerContent<Value>) {
        self.body = .init(title: title, image: image, selection: selection, content: content())
    }

    @available(*, unavailable, message: "Elements displayed at the transport bar root level require an associated image")
    public init(title: String, selection: Binding<Value>, @PickerContentBuilder<Value> content: () -> PickerContent<Value>) {
        fatalError()
    }
}

extension Picker where Value == Never {
    @available(*, unavailable, message: "Picker without a parent. Add a `selection` parameter to turn this picker into a parent picker")
    public init(title: String, image: UIImage? = nil, @PickerContentBuilder<Never> content: () -> PickerContent<Never>) {
        fatalError()
    }
}
