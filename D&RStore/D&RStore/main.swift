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
 TODO: - Main Menu
 TODO: - Search menu (min-max price, genre, search with title)
 TODO: - Category menu
 TODO: - User Cart Menu (user can add and delete book to the cart, or checkout)
 TODO: - Paymnet Menu
 
 TODO: - Different User Type (admin can add and delete book) ✅


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
    case deleteProduct
    case listProduct
    case searchProduct
    case printCart
    case exit
    //case addProductToCart = "5"
    //case detailProduct = "6"
}

enum ProductDetailMenu: Int{
    case addToCart = 1
    case showDetails  // with index
    case deleteProduct // only admin
}


func main(store:Store){
    //let store = Store()
    var isExit = false
    let user = getUserInfo()
    
    while !isExit{
      print("Welcome, \(user.username) 🎉")
      print("1. add new product")
      print("2. delete product")
      print("3. list products")
      print("4. search product")
      print("5. print cart")
      print("6. Exit")
      print("Enter the number: ");let menu = readLine()
        if let menu = menu, let menuInt = Int(menu){
            if user.type == "admin" {
                var adminUser: adminUser = user as! adminUser
                switch Menu(rawValue:menuInt) {
                case .addProduct:
                    print("Title: ",terminator: ""); let title = readLine()!
                    print("Year: ",terminator: ""); let year = Int(readLine()!)!
                    print("Price: ",terminator: ""); let price = Double(readLine()!)!
                    print("Category: ",terminator: ""); let category = readLine()!
                    let product = Product(title: title, year: year, price: price, category: category)
                    print(product)
                    adminUser.addStore(item: product)
                case .deleteProduct:
                    print("delete")
                case .listProduct:
                    print("Products: "); store.showAll()
                    let choice = Int(readLine()!)
                    print("Menu")
                    // switch Case
        // BURADAN DEVAM
                    
                    // TODO: listelenen elemanlarla işlem yapabilmek için index i alan bir func
                case .searchProduct:
                    print("keyword: ", terminator: ""); let keyword = readLine()!
                    print(store.searchProduct(word: keyword))
                case .printCart:
                    adminUser.showCart()
                case .exit:
                    isExit = true
                default:
                    print("Wrong input")
                }
            }
            else{
                switch Menu(rawValue: menuInt){
                case .addProduct:
                    print("admin login required")
                    continue
                case .deleteProduct:
                    print("admin login required")
                    continue
                case .listProduct:
                    print("list")
                case .searchProduct:
                    print("search")
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
