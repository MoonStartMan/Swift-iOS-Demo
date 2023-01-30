//
//  ViewController.swift
//  Subscript-demo
//
//  Created by 王潇 on 2023/1/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var xiaoli = Student(math: 98, chinese: 97, english: 100)
        print(xiaoli.scoreOf(course: "math"))
        
        xiaoli["math"] = 99
        print(xiaoli["math"])
    }

    
}

struct Student {
    let name: String = ""
    var math: Int = 0
    var chinese: Int = 0
    var english: Int = 0
    
    func scoreOf(course: String) -> Int? {
        switch course {
        case "math":
            return math
        case "chinese":
            return chinese
        case "english":
            return english
        default:
            return nil
        }
    }
    
    subscript (course: String) -> Int? {
        get {
            switch course {
            case "math":
                return math
            case "chinese":
                return chinese
            case "english":
                return english
            default:
                return nil
            }
        }
        set {
            switch course {
            case "math":
                return math = newValue!
            case "chinese":
                return chinese = newValue!
            case "english":
                return english = newValue!
            default:
                print("key wrong")
            }
        }
    }
}
