//
//  AppDelegate.swift
//  iOS-Touch-CreatePoint-Demo
//
//  Created by 王潇 on 2023/3/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var point: CGPoint = CGPoint(x: 0, y: 0)
        for touch in touches {
            let t: UITouch = touch
            point = t.location(in: PointCursorView.shared)
            PointCursorView.shared.pointViewTouchesBegan(point: point)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var point: CGPoint = CGPoint(x: 0, y: 0)
        for touch in touches {
            let t: UITouch = touch
            point = t.location(in: PointCursorView.shared)
            PointCursorView.shared.pointViewTouchesMoved(point: point)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var point: CGPoint = CGPoint(x: 0, y: 0)
        for touch in touches {
            let t: UITouch = touch
            point = t.location(in: PointCursorView.shared)
            PointCursorView.shared.pointViewTouchesEnded(point: point)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        var point: CGPoint = CGPoint(x: 0, y: 0)
        for touch in touches {
            let t: UITouch = touch
            point = t.location(in: PointCursorView.shared)
            PointCursorView.shared.pointViewTouchesEnded(point: point)
        }
    }

}

