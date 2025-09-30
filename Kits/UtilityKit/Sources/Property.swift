//


@propertyWrapper
public struct Property<Value: Sendable>: Sendable {
    
    // MARK: - Properties
    
    private let get: @Sendable () -> Value
    private let set: @Sendable (Value) -> Void
    
    
    // MARK: - Implementation
    
    public var wrappedValue: Value {
        get {
            get()
        }
        nonmutating set {
            set(newValue)
        }
    }
    
    
    // MARK: - Init
    
    public init(get: @escaping @Sendable () -> Value, set: @escaping @Sendable (Value) -> Void) {
        self.get = get
        self.set = set
    }
    
    public init(get: @autoclosure @escaping @Sendable () -> Value, set: @escaping @Sendable (Value) -> Void) {
        self.get = get
        self.set = set
    }
    
    
    // MARK: - Convenience
    
    public static func constant(_ value: Value) -> Self {
        .init(
            get: { value },
            set: { _ in }
        )
    }
    
    public static func property<Object: AnyObject & Sendable>(
        _ object: Object,
        keyPath: ReferenceWritableKeyPath<Object, Value> & Sendable
    ) -> Self {
        Property(
            get: { object[keyPath: keyPath] },
            set: { object[keyPath: keyPath] = $0 }
        )
    }
}
