//
//  panpelProtocol.swift
//  panpelProtocol-Demo
//
//  Created by 王潇 on 2022/7/16.
//

import UIKit

protocol EditViewControllerDelegate: AnyObject {
    func editInfo(controller: EditViewController, newInfo: String)
    func editInfoDidCancer(controller: EditViewController)
}

