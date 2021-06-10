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
    
    //  第一次记录
    var inputFirstString: String = ""
    //  第二次记录
    var inputSecondString: String = ""
    //  历史表达式字符串
    var historyString: String = "0"
    //  结果
    var resultString: String = ""
    
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
        cell.btnLabel?.text = self.dataArray[indexPath.row] as! String
        if(indexPath.row >= 0 && indexPath.row <= 2) {
            let normalColor = UIColor.init(red: 165/255.0, green: 165/255.0, blue: 165/255.0, alpha: 1.0)
//            let hightColor = UIColor.init(red: 165/255.0, green: 165/255.0, blue: 165/255.0, alpha: 0.5)
            cell.btnView?.backgroundColor = normalColor;
        } else if (indexPath.row == 3 || indexPath.row == 7 || indexPath.row == 11 || indexPath.row == 15 || indexPath.row == 19) {
            let normalColor = UIColor.init(red: 241/255.0, green: 163/255.0, blue: 60/255.0, alpha: 1.0)
//            let hightColor = UIColor.init(red: 241/255.0, green: 163/255.0, blue: 60/255.0, alpha: 0.5)
            cell.btnView?.backgroundColor = normalColor;
        } else {
            let normalColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
//            let hightColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 0.5)
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
                guard !self.historyString.contains(".") else {
                    return
                }
                self.historyString.append(self.dataArray[index])
                self.bottomDelegate?.showValue(value: self.historyString)
            } else {
                if historyString == "0" {
                    self.historyString.removeFirst()
                    self.historyString.append(self.dataArray[index])
                } else {
                    self.historyString.append(self.dataArray[index])
                }
                self.bottomDelegate?.showValue(value: self.historyString)
            }
        } else if (index == 0) {
            //  清零
            self.historyString = "0"
            self.bottomDelegate?.showValue(value: self.historyString)
        } else if (index == 1) {
            //  取反
            if self.historyString.contains("-") {
                guard let charIndex = self.historyString.firstIndex(of: "-") else { return  }
                self.historyString.remove(at: charIndex)
            } else {
                self.historyString.insert("-", at: self.historyString.startIndex)
            }
            self.bottomDelegate?.showValue(value: self.historyString)
        } else if (index == 2) {
            //  除100
            if let result = Double(self.historyString) {
                self.historyString = "\(result * 0.01)"
            }
            self.bottomDelegate?.showValue(value: self.historyString)
        } else if (index == 3 || index == 7 || index == 11 || index == 15) {
            self.inputFirstString = "\(self.historyString)"
            self.historyString = "0"
            self.bottomDelegate?.showValue(value: self.historyString)
            var num1: Double = 0.0
            if let n1 = Double(self.inputFirstString) {
                num1 = n1
            }
            var num2: Double = 0.0
            if let n2 = Double(self.historyString) {
                num2 = n2
            }
            switch index {
            case 3:
                // 除
                self.resultString = "\(num1 / num2)"
                break
            case 7:
                // 乘
                self.resultString = "\(num1 * num2)"
                break
            case 11:
                // 减
                self.resultString = "\(num1 - num2)"
                break
            case 15:
                // 加
                self.resultString = "\(num1 + num2)"
                break
            default:
                break
            }
        } else if (index == 18) {
            self.inputSecondString = "\(self.historyString)"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
