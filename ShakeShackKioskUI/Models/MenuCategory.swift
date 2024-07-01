enum MenuCategory: String {
    case burgers = "Burgers"
    case frozenCustard = "Frozen Custard"
    case drinks = "Drinks"
    case beer = "Beer"

    var items: [MenuItem] {
        switch self {
        case .burgers:
            return [
                MenuItem(name: "ShackBurger", price: 6.9),
                MenuItem(name: "SmokeShack", price: 8.9),
                MenuItem(name: "Shroom Burger", price: 9.4),
                MenuItem(name: "Cheeseburger", price: 6.9),
                MenuItem(name: "Hamburger", price: 5.4)
            ]
        case .frozenCustard:
            return [
                MenuItem(name: "Vanilla Custard", price: 3.5),
                MenuItem(name: "Chocolate Custard", price: 3.5)
            ]
        case .drinks:
            return [
                MenuItem(name: "Lemonade", price: 2.5),
                MenuItem(name: "Iced Tea", price: 2.5),
                MenuItem(name: "Soda", price: 2.0)
            ]
        case .beer:
            return [
                MenuItem(name: "ShackMeister Ale", price: 5.0)
            ]
        }
    }
}
