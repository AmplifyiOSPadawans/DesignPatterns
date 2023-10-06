import UIKit

// MARK: Singleton
/*class DatabaseHelper {
    
    static let shared = DatabaseHelper()
    private init() { }
    
    
    func save(message: String) {
        print("Message saved: \(message)")
            // Some logic
    }
    
    func fetch(message: String) -> String {
        print("Fetch message: \(message)")
            // Some logic
        return "Esta es la data que leí"
    }
}



DatabaseHelper.shared.save(message: "Estoy guardando data")
let result = DatabaseHelper.shared.fetch(message: "Estoy trayendo data")
print(result)*/


// MARK: Builder

/*public struct Hamburger {
    public let meat: Meat
    public let sauce: Sauces
    public let toppings: Toppings
}

extension Hamburger: CustomStringConvertible {
    public var description: String {
        return ("Here is your burger. It has \(meat.rawValue) as meat; \(sauce.description) as sauce; and \(toppings.description) as topping in it. Bon Appetit!")
    }
}

public enum Meat: String {
    case beef
    case chicken
    case tofu
}

public struct Sauces: OptionSet {
    
    public let rawValue: Int
    
    public static let mayonnaise = Sauces(rawValue: 1 << 0)
    public static let mustard = Sauces(rawValue: 1 << 1)
    public static let ketchup = Sauces(rawValue: 1 << 2)
    public static let barbeque = Sauces(rawValue: 1 << 3)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension Sauces: CustomStringConvertible {
    
    static public var debugDescriptions: [(Self, String)] = [
        (.mayonnaise, "mayonnaise"),
        (.mustard, "mustard"),
        (.ketchup, "ketchup"),
        (.barbeque, "barbeque")
    ]
    
    public var description: String {
        let result: [String] = Self.debugDescriptions.filter { contains($0.0) }.map { $0.1 }
        let printable = result.joined(separator: ", ")
        
        return "\(printable)"
    }
}

public struct Toppings: OptionSet {
    public let rawValue: Int
    
    public static let cheese = Toppings(rawValue: 1 << 0)
    public static let onion = Toppings(rawValue: 1 << 1)
    public static let lettuce = Toppings(rawValue: 1 << 2)
    public static let pickles = Toppings(rawValue: 1 << 3)
    public static let tomatoes = Toppings(rawValue: 1 << 4)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension Toppings: CustomStringConvertible {
    
    static public var debugDescriptions: [(Self, String)] = [
        (.cheese, "cheese"),
        (.onion, "onion"),
        (.lettuce, "lettuce"),
        (.pickles, "pickles"),
        (.tomatoes, "tomatoes")
    ]
    
    public var description: String {
        let result: [String] = Self.debugDescriptions.filter { contains($0.0) }.map { $0.1 }
        let printable = result.joined(separator: ", ")
        
        return "\(printable)"
    }
}

public class HamburgerBuilder {
    
    public private(set) var meat: Meat = .beef
    public private(set) var sauces: Sauces = []
    public private(set) var toppings: Toppings = []
    
    public func addSauces(_ sauce: Sauces) {
        sauces.insert(sauce)
    }
    public func removeSauces(_ sauce: Sauces) {
        sauces.remove(sauce)
    }
    public func addToppings(_ topping: Toppings) {
        toppings.insert(topping)
    }
    public func removeToppings(_ topping: Toppings) {
        toppings.remove(topping)
    }
    public func setMeat(_ meat: Meat) {
        self.meat = meat
    }
    
    public func build() -> Hamburger {
        return Hamburger(meat: meat,
                         sauce: sauces,
                         toppings: toppings)
    }
}

public func createCheeseBurger(using builder: HamburgerBuilder) -> Hamburger {
    builder.setMeat(.beef)
    builder.addToppings([.cheese, .lettuce, .tomatoes])
    builder.addSauces([.barbeque, .ketchup, .mayonnaise])
    return builder.build()
}

public func createVegetarianBurger(using builder: HamburgerBuilder) -> Hamburger {
    builder.setMeat(.tofu)
    builder.addSauces([.mayonnaise, .mustard])
    builder.addToppings([.lettuce, .tomatoes, .pickles])
    return builder.build()
}


let hamburgerBuilder = HamburgerBuilder()



let cheeseBurger = createCheeseBurger(using: hamburgerBuilder)
let vegetarianBurger = createVegetarianBurger(using: hamburgerBuilder)


print(cheeseBurger.description)

print(vegetarianBurger.description)
*/

// MARK: Adapter
/*
protocol AuthService {
    func presentAuthFlow(from viewController: UIViewController)
}


class FacebookAuthSDK {
    
    func presentAuthFlow(from viewController: UIViewController) {
        print("Facebook WebView has been shown.")
    }
}


extension FacebookAuthSDK: AuthService {
        /// This extension just tells a compiler that both SDKs have the same
        /// interface.
}


class TwitterAuthSDK {
    
    func startAuthorization(with viewController: UIViewController) {
        print("Twitter WebView has been shown. Users will be happy :)")
    }
}

extension TwitterAuthSDK: AuthService {
    
    /// This is an adapter
    ///
    /// Yeah, we are able to not create another class and just extend an
    /// existing one
    
    func presentAuthFlow(from viewController: UIViewController) {
        print("The Adapter is called! Redirecting to the original method...")
        self.startAuthorization(with: viewController)
    }
}

func testAdapterRealWorld() {
    
    print("Starting an authorization via Facebook")
    startAuthorization(with: FacebookAuthSDK())
    
    print("Starting an authorization via Twitter.")
    startAuthorization(with: TwitterAuthSDK())
}

func startAuthorization(with service: AuthService) {
    let topViewController = UIViewController()
    
    service.presentAuthFlow(from: topViewController)
}

testAdapterRealWorld()*/

// MARK: Observer

protocol CartSubscriber: CustomStringConvertible {
    
    func accept(changed cart: [Product])
}

protocol Product {
    
    var id: Int { get }
    var name: String { get }
    var price: Double { get }
    
    func isEqual(to product: Product) -> Bool
}

extension Product {
    
    func isEqual(to product: Product) -> Bool {
        return id == product.id
    }
}

struct Food: Product {
    
    var id: Int
    var name: String
    var price: Double
    
        /// Food-specific properties
    var calories: Int
}

struct Clothes: Product {
    
    var id: Int
    var name: String
    var price: Double
    
        /// Clothes-specific properties
    var size: String
}

class CartManager {
    
    private lazy var cart = [Product]()
    private lazy var subscribers = [CartSubscriber]()
    
    func add(subscriber: CartSubscriber) {
        print("CartManager: I'am adding a new subscriber: \(subscriber.description)")
        subscribers.append(subscriber)
    }
    
    func add(product: Product) {
        print("\nCartManager: I'am adding a new product: \(product.name)")
        cart.append(product)
        notifySubscribers()
    }
    
    func remove(subscriber filter: (CartSubscriber) -> (Bool)) {
        guard let index = subscribers.firstIndex(where: filter) else { return }
        subscribers.remove(at: index)
    }
    
    func remove(product: Product) {
        guard let index = cart.firstIndex(where: { $0.isEqual(to: product) }) else { return }
        print("\nCartManager: Product '\(product.name)' is removed from a cart")
        cart.remove(at: index)
        notifySubscribers()
    }
    
    private func notifySubscribers() {
        subscribers.forEach({ $0.accept(changed: cart) })
    }
}



class CartViewController: UIViewController, CartSubscriber {
    
    func accept(changed cart: [Product]) {
        print("CartViewController: Updating an appearance of a list view with products")
    }
    
    open override var description: String { return "CartViewController" }
}

extension UINavigationBar: CartSubscriber {
    
    func accept(changed cart: [Product]) {
        print("UINavigationBar: Updating an appearance of navigation items")
    }
    
    open override var description: String { return "UINavigationBar" }
}

func runObserver() {
    
    let cartManager = CartManager()
    
    
    let cartVC = CartViewController()
    let navBar = UINavigationBar()
    
    cartManager.add(subscriber: cartVC)
    cartManager.add(subscriber: navBar)
    
    let apple = Food(id: 111, name: "Apple", price: 10, calories: 20)
    cartManager.add(product: apple)
    
    let tShirt = Clothes(id: 222, name: "T-shirt", price: 200, size: "L")
    cartManager.add(product: tShirt)
    
    cartManager.remove(product: apple)
}

runObserver()
