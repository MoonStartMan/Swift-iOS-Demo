//
//  TbaleViewController.swift
//  AutoLayout-Demo
//
//  Created by 王潇 on 2022/12/21.
//

import UIKit

class TbaleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? TableViewCell else {
            fatalError()
        }
        cell.textString = textArray[indexPath.row]
        cell.backgroundColor = .systemPink
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    private var tableView: UITableView = UITableView(frame: .zero)
    
    var textArray: [String] =
    [
        "Life is beautiful, but its complicated. We barely make it. We dont need to understand. There are miracles, miracles.",
        "'Maybe I dont have the blonde hair you like, Or maybe I dont have eyes like the sky. And Im not sure if Im the girl in your dream' 's, But' I ca n s how you what love mean s 《 girl in your dreams》",
        "Remember, the brick walls are there for a reason. The brick walls are not there to keep us out. The brick walls are there to give us a chance to show how badly we want someting. Because the brick walls are there to stop the people who don't want it badly enough. They're there to stop the other people.",
        ""
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableViewLeft = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let tableViewRight = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let tableViewTop = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 44)
        let tableViewBottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -34)
        tableView.superview?.addConstraints([tableViewLeft, tableViewRight, tableViewTop, tableViewBottom])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "CellID")
    }

}
