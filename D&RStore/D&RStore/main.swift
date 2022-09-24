//
//  main.swift
//  D&RStore
//
//  Created by utku on 22.09.2022.
//

import Foundation

/*
 MARK: - D&R Store App
 
 TODO: - Sign Up ✅
 TODO: - Main Menu ✅
 TODO: - Search menu ()✅
 TODO: - User Cart Menu (user can add and delete book to the cart, or checkout) ✅
 TODO: - Paymnet Menu✅
 TODO: - Different User Type (admin can add and delete book) ✅

 ----

 TODO: - Add and delete to store ✅
 TODO: - list products ✅
 TODO: - print cart ✅
 TODO: - add to cart ✅
 TODO: - exit ✅

 */






/* MARK: Product*/
class Product: Equatable{
    var title: String
    var year: Int
    var price: Double
    var category:String
    //var stock: Int{get set}
 
    init(title: String, year: Int, price: Double, category: String) {
        self.title = title
        self.year = year
        self.price = price
        self.category = category
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.title == rhs.title
    }
}

class Movie : Product{
    var director: String?
    var minutes: Int?
    
    init(title: String, year:Int, price:Double, category:String, director: String?, minutes: Int?) {
        super.init(title: title, year: year, price: price, category: category)
        self.director = director
        self.minutes = minutes
    }
}

class Book : Product{
    var author: String?
    var pageNumber: Int?
    
    init(title: String, year:Int, price:Double, category:String, author: String?, pageNumber: Int?) {
        super.init(title: title, year: year, price: price, category: category)
        self.author = author
        self.pageNumber = pageNumber
    }
    
}


/* MARK: User*/
class User:Equatable {
    var type : String
    var username: String
    var cart: [Product] = []
    
    init(type: String, username: String) {
        self.type = type
        self.username = username
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username
    }
    
    
    // show cart
    func showCart(){
        for (index,product) in cart.enumerated() {
            print("\(index). \(product)")
        }
    }
    
    // add to cart
    func addToCart(item:Product){
        cart.append(item)
    }
    // delete to cart TODO: guard let eklenebilir
    func deleteToCart(item:Product) throws {
        let result = cart.firstIndex(of: item)
        cart.remove(at: result!)
    }
    // find total amount of the product
    func totalAmount() -> Double{
        var totalAmount: Double = 0
        for product in cart {
            totalAmount += product.price
        }
        return totalAmount
    }

    
}


//var user1 = User(id: 1, username: "utku", chart:[] )

class standartUser : User{
    override init(type : String = "user", username: String) {
        super.init(type: type, username: username)
    }
}


class adminUser : User{
    override init(type: String = "admin", username: String = "admin") {
        super.init(type: type, username: username)
    }
    // add to Store
    func addStore(item:Product){
        store.products.append(item)
    }
    // delete to Store
    func deleteFromStore(item:Product){
        store.products.remove(at: store.products.firstIndex(of: item)!)
    }
}


func getUserInfo()-> User{
    print("Enter the username: ");let username = readLine()!
    print("admin or user: ");let type = readLine()!
    if(type == "admin"){
        return adminUser(type: type, username: username)
    }else{
        return standartUser(type: type, username: username)
    }
}



/* MARK: PAYMENT*/

// credit card , cash, bitcoin
class Payment{
    var type: String
    var amount: Double
    
    init(type: String, amount: Double) {
        self.type = type
        self.amount = amount
    }
    
    func pay(){
        
    }
}

class CreditCard: Payment{
    var cardNumber: Int
    
    init(type: String = "Credit Card", amount: Double, cardNumber: Int) {
        self.cardNumber = cardNumber
        super.init(type: type, amount: amount)
    }
    override func pay() {
        print("Payment is done with credit card")
    }
}

class Cash: Payment{
   override init(type: String = "Cash", amount: Double) {
        super.init(type: type, amount: amount)
    }
    override func pay() {
        print("Cash payment")
    }

}

class Bitcoin: Payment{
    var bitcoinAddress: String
    
    init(type: String = "Bitcoin", amount: Double, bitcoinAddress: String) {
        self.bitcoinAddress = bitcoinAddress
        super.init(type: type, amount: amount)
    }
    override func pay() {
        print("Paymnet is done with bitcoin")
    }

}




/* MARK: Main*/
class Store {
    var products:[Product] = []
    
    func showAll(){
        for (index,product) in products.enumerated() {
            print("\(index). \(product.title)")
        }
    }
    func searchProduct(word: String) -> [Product]{
        let result = products.filter { $0.title.contains(word) }
        return result
    }
}



enum Menu: Int{
    case addProduct = 1
    case listProduct
    case searchProduct
    case printCart
    case checkOut
    case exit
    //case addProductToCart = "5"
    //case detailProduct = "6"
}

enum ProductDetailMenu: Int{
    case addToCart = 1
    case showDetails  // with index
    case deleteProduct // only admin
}

enum paymentMenu: Int {
    case creditCard = 1
    case cash
    case bitcoin
}


func main(store:Store){
    //let store = Store()
    var isExit = false
    let user = getUserInfo()
    
    while !isExit{
        print("Welcome, \(user.username) 🎉")
        print("1. add new product")
        print("2. list products")
        print("3. search product")
        print("4. print cart")
        print("5. pay")
        print("6. Exit")
        print("Enter the number: ");let menu = readLine()
        if let menu = menu, let menuInt = Int(menu){
            if user.type == "admin" {
                let adminUser: adminUser = user as! adminUser
                switch Menu(rawValue:menuInt) {
                case .addProduct:
                    print("Title: ",terminator: ""); let title = readLine()!
                    print("Year: ",terminator: ""); let year = Int(readLine()!)!
                    print("Price: ",terminator: ""); let price = Double(readLine()!)!
                    print("Category: ",terminator: ""); let category = readLine()!
                    let product = Product(title: title, year: year, price: price, category: category)
                    print(product)
                    adminUser.addStore(item: product)
                case .listProduct:
                    print("Products: "); store.showAll()
                    // choose product and show details
                    print("Enter the product index: "); let index = Int(readLine()!)!
                    print("1. add to cart")
                    print("2. show details")
                    print("3. delete product")
                    print("Enter the number: "); let detailMenu = readLine()
                    if let detailMenu = detailMenu, let detailMenuInt = Int(detailMenu){
                        switch ProductDetailMenu(rawValue:detailMenuInt) {
                        case .addToCart:
                            adminUser.addToCart(item: store.products[index])
                            print("add to cart ✅")
                        case .showDetails:
                            print(store.products[index].title)
                            print(store.products[index].year)
                            print(store.products[index].price)
                        case .deleteProduct:
                            adminUser.deleteFromStore(item: store.products[index])
                            print("product deleted ❌")
                        default:
                            print("default")
                        }
                    }
                    
                    
                    
                case .searchProduct:
                    print("keyword: ", terminator: ""); let keyword = readLine()!
                    print(store.searchProduct(word: keyword))
                case .printCart:
                    adminUser.showCart()
                    
                    
                case .checkOut:
                    var money = adminUser.totalAmount()
                    // payment
                    
                    print("1. Credit Card")
                    print("2. Cash")
                    print("3. Bitcoin")
                    print("Enter the number: "); let paymentMethod = readLine()
                    if let paymentMethod = paymentMethod, let paymentMethodInt = Int(paymentMethod){
                        switch paymentMenu(rawValue: paymentMethodInt) {
                        case .creditCard:
                            print("Card Number: ", terminator: ""); let cardNumber = Int(readLine()!)!
                            let payment = CreditCard(amount: money, cardNumber: cardNumber)
                            payment.pay()
                        case .cash:
                            let payment = Cash(amount: money)
                            payment.pay()
                        case .bitcoin:
                            print("Bitcoin Address: ", terminator: ""); let bitcoinAddress = readLine()!
                            let payment = Bitcoin(amount: money, bitcoinAddress: bitcoinAddress)
                            payment.pay()
                        default:
                            print("default")
                        }
                    }
                case .exit:
                    isExit = true
                default:
                    print("Wrong input")
                }
            }
            else{
                let user: standartUser = user as! standartUser
                switch Menu(rawValue: menuInt){
                case .addProduct:
                    print("admin login required")
                    continue
                case .listProduct:
                    print("Products: "); store.showAll()
                    // choose product and show details
                    print("Enter the product index: "); let index = Int(readLine()!)!
                    print("1. add to cart")
                    print("2. show details")
                    print("3. delete product")
                    print("Enter the number: "); let detailMenu = readLine()
                    if let detailMenu = detailMenu, let detailMenuInt = Int(detailMenu){
                        switch ProductDetailMenu(rawValue:detailMenuInt) {
                        case .addToCart:
                            user.addToCart(item: store.products[index])
                            print("added to cart ✅")
                        case .showDetails:
                            print(store.products[index].title)
                            print(store.products[index].year)
                            print(store.products[index].price)
                        case .deleteProduct:
                            print("admin only")
                        default:
                            print("default")
                        }
                    }
                case .searchProduct:
                    print("search")
                case .printCart:
                    user.showCart()
                case .checkOut:
                    var money = user.totalAmount()
                    // payment
                    
                    print("1. Credit Card")
                    print("2. Cash")
                    print("3. Bitcoin")
                    print("Enter the number: "); let paymentMethod = readLine()
                    if let paymentMethod = paymentMethod, let paymentMethodInt = Int(paymentMethod){
                        switch paymentMenu(rawValue: paymentMethodInt) {
                        case .creditCard:
                            print("Card Number: ", terminator: ""); let cardNumber = Int(readLine()!)!
                            let payment = CreditCard(amount: money, cardNumber: cardNumber)
                            payment.pay()
                        case .cash:
                            let payment = Cash(amount: money)
                            payment.pay()
                        case .bitcoin:
                            print("Bitcoin Address: ", terminator: ""); let bitcoinAddress = readLine()!
                            let payment = Bitcoin(amount: money, bitcoinAddress: bitcoinAddress)
                            payment.pay()
                        default:
                            print("default")
                        }
                    }
                case .exit:
                    isExit = true
                default:
                    print("invalid number")
                }
            }
        }
    }
}
    
    let store = Store()
    store.products.append(Product(title: "Wong kar wai üzerine kısa bir film", year: 1999, price: 20.0, category: "new"))
    //print(store.products[0].title)
    main(store: store)

