//
//  main.swift
//  BookStore
//
//  Created by utku on 22.09.2022.
//

import Foundation

/*
 MARK: - Book Store App
 
 TODO: - Sign Up
 TODO: - Main Menu
 TODO: - Search menu (min-max price, genre, search with title)
 TODO: - Category menu
 TODO: - User Cart Menu (user can add and delete book to the cart, or checkout)
 TODO: - Paymnet Menu
 
 TODO: - Different User Type (admin can add and delete book)


 */
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



class Store {
    var products:[Product] = []
    var movie1 = Movie(title: "Wong kar wai hakkında kısa bir film", year: 1999, price: 100, category: "Kısa Film", director: "Something", minutes: 30)
    
    
    func showAll(){
        products.append(movie1)
        for (index,product) in products.enumerated() {
            print("\(index). \(product.title)")
        }
    }
}



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
    
    // search
    func search(word: String, array: [Product]) -> [Product]{
        let result = array.filter { $0.title.contains(word) }
        return result
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
    override init(type : String = "Standart User", username: String) {
        super.init(type: type, username: username)
    }
}

class adminUser : User{
    override init(type: String = "Admin", username: String = "admin") {
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

func SignUp(){
    let user = getUserInfo()
    print("Welcome to the Movie Store \(user.username)")
   
}

var store = Store()

store.showAll()








