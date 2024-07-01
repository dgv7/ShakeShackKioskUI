struct MenuItem: Hashable {
    let name: String
    let price: Double

    // Hashable을 준수하기 위해 Equatable과 Hashable을 구현합니다.
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(price)
    }
}
