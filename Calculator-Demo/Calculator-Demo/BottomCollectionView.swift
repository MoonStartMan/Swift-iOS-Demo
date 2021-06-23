//
//  BottomBtnView.swift
//  Calculator-Demo
//
//  Created by 王潇 on 2021/6/8.
//

import UIKit
import SnapKit

protocol CalculateDelegate: NSObject {
    func showValue(value: String)
}

class BottomCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //  上一次记录
    var lastInput: String = "0"
    //  当前记录
    var currentInput: String = "0"
    // 计算符号
    var ch: String = ""
    //  上一次计算符号
    var lastCh: String = ""
    
    //  delegate
    weak var bottomDelegate: CalculateDelegate?
    
    var dataArray = ["AC", "+/-", "%", "÷", "7", "8", "9", "×", "4", "5", "6", "-", "1", "2", "3", "+", "0", ".", "="]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self;
        self.dataSource = self;
        self.register(BottomCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:BottomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! BottomCollectionViewCell
        cell.btnLabel?.text = self.dataArray[indexPath.row]
        if(indexPath.row >= 0 && indexPath.row <= 2) {
            let normalColor = UIColor.init(red: 165/255.0, green: 165/255.0, blue: 165/255.0, alpha: 1.0)
            cell.btnView?.backgroundColor = normalColor;
        } else if (indexPath.row == 3 || indexPath.row == 7 || indexPath.row == 11 || indexPath.row == 15 || indexPath.row == 19) {
            let normalColor = UIColor.init(red: 241/255.0, green: 163/255.0, blue: 60/255.0, alpha: 1.0)
            cell.btnView?.backgroundColor = normalColor;
        } else {
            let normalColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
            cell.btnView?.backgroundColor = normalColor;
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == 16) {
            return CGSize.init(width: self.frame.size.width / 2 , height: self.frame.size.width / 4 - 10)
        } else {
            return CGSize.init(width: self.frame.size.width / 4 - 10, height: self.frame.size.width / 4 - 10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        if(index == 4 || index == 5 || index == 6 || index == 8 || index == 9 || index == 10 || index == 12 || index == 13 || index == 14 || index == 16 || index == 17) {
            if (index == 17) {
                guard !self.currentInput.contains(".") else {
                    return
                }
                self.currentInput.append(self.dataArray[index])
                self.bottomDelegate?.showValue(value: self.currentInput)
            } else {
                if currentInput == "0" {
                    self.currentInput.removeFirst()
                }
                self.currentInput.append(self.dataArray[index])
                self.bottomDelegate?.showValue(value: self.currentInput)
            }
            self.ch = ""
        } else if (index == 0) {
            //  清零
            self.clear()
            self.bottomDelegate?.showValue(value: self.currentInput)
        } else if (index == 1) {
            //  取反
            let num1 = self.strChangeDouble(self.lastInput)
            let num2 = self.strChangeDouble(self.currentInput)
            var result = "\(num1 + num2)"
            if result.contains("-") {
                guard let charIndex = result.firstIndex(of: "-") else { return  }
                result.remove(at: charIndex)
            } else {
                result.insert("-", at: result.startIndex)
            }
            self.lastInput = "0"
            self.currentInput = result
            self.bottomDelegate?.showValue(value: self.currentInput)
            
        } else if (index == 2) {
            //  除100
            let num1 = self.strChangeDouble(self.lastInput)
            let num2 = self.strChangeDouble(self.currentInput)
            let result = num1 + num2
            self.currentInput = "\(result * 0.01)"
            self.lastInput = "0"
            self.bottomDelegate?.showValue(value: self.currentInput)
        } else if (index == 3 || index == 7 || index == 11 || index == 15) {
            var result: String = ""
            if (!self.ch.isEmpty) {
                return
            }
            switch index {
            case 3:
                // 除
                self.ch = "/"
                break
            case 7:
                // 乘
                self.ch = "*"
                break
            case 11:
                // 减
                self.ch = "-"
                break
            case 15:
                // 加
                self.ch = "+"
                break
            default:
                break
            }
            if (self.lastCh.isEmpty) {
                result = self.currentInput
                self.lastInput = self.currentInput
                self.currentInput = "0"
            } else {
                result = self.calculator()
            }
            self.lastCh = self.ch
            self.bottomDelegate?.showValue(value: result)
        } else if (index == 18) {
            let result = self.calculator()
            self.ch = ""
            self.bottomDelegate?.showValue(value: result)
        }
    }
    
    //  清零操作
    func clear() {
        self.currentInput = "0"
        self.lastInput = "0"
        self.ch = ""
        self.lastCh = ""
    }
    
    //  String转Double
    func strChangeDouble(_ str:String) -> Double {
        if let n1 = Double(str) {
            return n1
        }
        return 0
    }
    
    func add() -> String {
        let num1 = self.strChangeDouble(self.lastInput)
        let num2 = self.strChangeDouble(self.currentInput)
        
        self.lastInput = "\(num1 + num2)"
        
        self.currentInput = "0"
        return self.lastInput
    }
    
    //  计算操作 -
    func subtract() -> String {
        let num1 = self.strChangeDouble(self.lastInput)
        let num2 = self.strChangeDouble(self.currentInput)
        
        if (self.lastInput == "0") {
            self.lastInput = self.currentInput
        } else {
            self.lastInput = "\(num1 - num2)"
        }
        
        self.currentInput = "0"
        return self.lastInput
    }
    
    //  计算操作 *
    func multiply() -> String {
        let num1 = self.strChangeDouble(self.lastInput)
        let num2 = self.strChangeDouble(self.currentInput)
        
        if (num2 == 0) {
            return lastInput
        }
        
        if (self.lastInput == "0") {
            self.lastInput = self.currentInput
        } else {
            self.lastInput = "\(num1 * num2)"
        }
        
        self.currentInput = "0"
        return self.lastInput
    }
    
    //  计算操作 /
    func divide() -> String {
        let num1 = self.strChangeDouble(self.lastInput)
        let num2 = self.strChangeDouble(self.currentInput)
        
        if (num2 == 0) {
            return lastInput
        }
        
        if (self.lastInput == "0") {
            self.lastInput = self.currentInput
        } else {
            self.lastInput = "\(num1 / num2)"
        }
        
        self.currentInput = "0"
        return self.lastInput
    }
    
    //  计算方法
    func calculator() -> String {
        var result: String = ""
        switch self.lastCh {
        case "+":
            result = self.add()
            break
        case "-":
            result = self.subtract()
            break
        case "*":
            result = self.multiply()
            break
        case "/":
            result = self.divide()
            break
        default:
            break
        }
        return result
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
