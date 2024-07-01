class Cart {
    static let shared = Cart()
    private(set) var items: [MenuItem: Int] = [:]

    func addItem(_ item: MenuItem) {
        if let count = items[item] {
            items[item] = count + 1
        } else {
            items[item] = 1
        }
    }

    func removeItem(_ item: MenuItem) {
        if let count = items[item], count > 1 {
            items[item] = count - 1
        } else {
            items[item] = nil
        }
    }

    func clear() {
        items.removeAll()
    }
}
