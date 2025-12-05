@resultBuilder
public enum SelectionMenuContentBuilder<Value> {
    public typealias Expression = SelectionMenuElement<Value>
    public typealias Component = [Expression]
    public typealias Result = SelectionMenuContent<Value>

    public static func buildExpression(_ expression: Expression) -> Component {
        [expression]
    }

    public static func buildBlock(_ components: Component...) -> Component {
        components.flatMap(\.self)
    }

    public static func buildOptional(_ component: Component?) -> Component {
        component ?? []
    }

    public static func buildEither(first component: Component) -> Component {
        component
    }

    public static func buildEither(second component: Component) -> Component {
        component
    }

    public static func buildFinalResult(_ component: Component) -> Result {
        .init(children: component)
    }
}
