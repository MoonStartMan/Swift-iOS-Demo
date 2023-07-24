//
//  SolidCar.swift
//  SOLID-Demo
//
//  Created by 王潇 on 2023/7/24.
//

import Foundation

protocol DirectionProtocol {
    /// 向前
    func forward()
    /// 向后
    func backwords()
    /// 向左
    func turnLeft()
    /// 向右
    func turnRight()
}

protocol ExerciseProtocol {
    /// 移动
    func moving()
    /// 停止
    func stop()
}

protocol ActionsProtocol {
    /// 鸣笛
    func whistle()
    /// 关门
    func closeDoor()
    /// 开门
    func openDoor()
}

class Direction {
    /// 向前
    func forward() {
        print("向前移动")
    }
    /// 向后
    func backwords() {
        print("向后移动")
    }
    /// 向左
    func turnLeft() {
        print("向左移动")
    }
    /// 向右
    func turnRight() {
        print("向右移动")
    }
}

class Exercise {
    /// 移动
    func moving() {
        print("汽车移动了")
    }
    /// 停止
    func stop() {
        print("汽车停止了")
    }
}

class Actions {
    /// 鸣笛
    func whistle() {
        print("鸣笛~")
    }
    /// 关门
    func closeDoor() {
        print("关门~")
    }
    /// 开门
    func openDoor() {
        print("开门~")
    }
}

class Car: DirectionProtocol, ExerciseProtocol, ActionsProtocol {
    private let direction = Direction()
    private let exercise = Exercise()
    private let actions = Actions()
    
    func forward() { direction.forward() }
    
    func backwords() { direction.backwords() }
    
    func turnLeft() { direction.turnLeft() }
    
    func turnRight() { direction.turnRight() }
    
    func moving() { exercise.moving() }
    
    func stop() { exercise.stop() }
    
    func whistle() { actions.whistle() }
    
    func closeDoor() { actions.closeDoor() }
    
    func openDoor() { actions.openDoor() }
    
}
