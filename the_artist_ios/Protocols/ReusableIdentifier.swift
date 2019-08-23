protocol ReusableIdentifier {}

extension ReusableIdentifier {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
