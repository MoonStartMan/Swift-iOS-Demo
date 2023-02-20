//
//  SlidesView.swift
//  sideslip-demo
//
//  Created by 王潇 on 2023/2/17.
//

import UIKit

class SlidesView: UIView {
    
    private lazy var modelArray: [SlidesModelItem] = {
        return [
            SlidesModelItem(content: "content1"),
            SlidesModelItem(content: "content2"),
            SlidesModelItem(content: "content3"),
            SlidesModelItem(content: "content4"),
            SlidesModelItem(content: "content5"),
            SlidesModelItem(content: "content6")
        ]
    }()
    
    private var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SlidesCell.self, forCellReuseIdentifier: NSStringFromClass(SlidesCell.self))
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SlidesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(SlidesCell.self), for: indexPath) as? SlidesCell else {
            fatalError()
        }
        cell.model = modelArray[indexPath.item]
        cell.selectionStyle = .none
        return cell
    }
    
    /// 打开TableView 允许侧滑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// 侧滑样式
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    /// 修改编辑按钮的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }

    /// 删除操作
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { [weak self] (contextualAction, view, completionHandler) in
            tableView.setEditing(false, animated: true)
            self?.modelArray.remove(at: indexPath.item)
            tableView.reloadData()
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(named: "list_delete_btn")
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
    
    func getCurrentController() -> UIViewController? {
        var next = self.next
        repeat {
            if let next = next, next.isKind(of: UIViewController.self) {
                return next as? UIViewController
            }
            next = next?.next
        } while (next != nil)
        return nil
    }
}
