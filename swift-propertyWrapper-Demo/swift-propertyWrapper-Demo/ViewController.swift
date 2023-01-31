//
//  ViewController.swift
//  swift-propertyWrapper-Demo
//
//  Created by 王潇 on 2023/1/31.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var rectangle = SmallRectangle()
        print(rectangle.height)
        
        rectangle.height = 10
        print(rectangle.height)
        
        rectangle.height = 24
        print(rectangle.height)
        
        let user = User(firstName: "wang", lastName: "xiao")
        print(user.firstName, user.lastName)
        
        @LockAtomic
        var json: [String: String]?
        
        json = ["a": "1"]
        print(json)
    }

}

@propertyWrapper
struct SmallNumber {
    private var maximun: Int
    private var number: Int
    private(set) var projectedValue: Bool
    
    var wrappedValue: Int {
        get {
            return number
        }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    
    init() {
        maximun = 12
        number = 0
        projectedValue = false
    }
    
    init(wrappedValue: Int) {
        maximun = 12
        number = min(wrappedValue, maximun)
        if wrappedValue > 12 {
            projectedValue = true
        } else {
            projectedValue = false
        }
    }
    
    init(wrappedValue: Int, maximum: Int) {
        self.maximun = maximum
        number = min(wrappedValue, maximum)
        if number > maximum {
            projectedValue = true
        } else {
            projectedValue = false
        }
    }
}

/** 属性包装器👇🏻  **/

struct SmallRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

/** 属性包装器 👆🏻 **/

/** 转译后 👇🏻 **/

//struct SmallRectangle {
//    private var _height = TwelveOrLess()
//    private var _width = TwelveOrLess()
//    var height: Int {
//        get { return _height.wrappedValue }
//        set { _height.wrappedValue = newValue }
//    }
//    var width: Int {
//        get { return _width.wrappedValue }
//        set { _width.wrappedValue = newValue }
//    }
//}

/** 转译后 👆🏻 **/

struct NarrowRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

@propertyWrapper struct Capitalized {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

struct User {
    @Capitalized var firstName: String
    @Capitalized var lastName: String
}

@propertyWrapper
class LockAtomic<T> {
    private var value: T
    private let lock = NSLock()
    
    public init(wrappedValue value: T) {
        self.value = value
    }
    
    public var wrappedValue: T {
        get { getValue() }
        set { setValue(newValue: newValue) }
    }
    
    //  加锁处理获取数据
    func getValue() -> T {
        lock.lock()
        defer { lock.unlock() }
        
        return value
    }
    
    //  设置数据加锁
    func setValue(newValue: T) {
        lock.lock()
        defer { lock.unlock() }
        
        value = newValue
    }
}
