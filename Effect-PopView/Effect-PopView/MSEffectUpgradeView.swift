//
//  MSEffectUpgradeView.swift
//  Effect-PopView
//
//  Created by 王潇 on 2023/2/28.
//

import UIKit
import SnapKit

enum MSEffectUpgradeModelType {
    case video
    case text
}

class MSEffectUpgradeView: UIView {
    
    private var dataArray: [MSEffectUpgradeModel] = {
       return [
        MSEffectUpgradeModel(type: .video, title: "动态拼贴", subTitle: "调整图层的顺序改变拼贴效果，你的效果可能发生变化。", iconName: "upgarde_effect_icon", showUnderline: false),
        MSEffectUpgradeModel(type: .text, title: "定向模糊", subTitle: "", iconName: "upgarde_effect_icon", showUnderline: true),
        MSEffectUpgradeModel(type: .text, title: "边缘特效", subTitle: "", iconName: "upgarde_effect_icon", showUnderline: true),
        MSEffectUpgradeModel(type: .text, title: "描边", subTitle: "", iconName: "upgarde_effect_icon", showUnderline: false)
       ]
    }()
    
    private var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .hex("#000000", 0.6)
        return view
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .hex("#1A1A1A")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 24.0
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .hex("#FFFFFF")
        label.textAlignment = .left
        label.text = "效果已更新"
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .hex("#FFFFFF", 0.8)
        label.textAlignment = .left
        label.text = "更新可能会影响工程效果,请检查."
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MSEffectUpgardeVideoCell.self, forCellReuseIdentifier: NSStringFromClass(MSEffectUpgardeVideoCell.self))
        tableView.register(MSEffectUpgardeTextCell.self, forCellReuseIdentifier: NSStringFromClass(MSEffectUpgardeTextCell.self))
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private var submitBtn: UIButton = {
        let btn = UIButton()
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 14.0
        btn.setTitle("知道了", for: .normal)
        btn.setTitleColor(.hex("#1A1A1A"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        btn.backgroundColor = .hex("#D0FE18")
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView() {
        addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coverView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(311)
            make.height.equalTo(424)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.left.equalTo(24)
        }
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(24)
        }
        
        contentView.addSubview(submitBtn)
        submitBtn.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.bottom.right.equalTo(-24)
            make.height.equalTo(48)
        }
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(submitBtn.snp.top)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MSEffectUpgradeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataArray[indexPath.item].type == .video {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MSEffectUpgardeVideoCell.self), for: indexPath) as? MSEffectUpgardeVideoCell else {
                fatalError()
            }
            cell.model = dataArray[indexPath.item]
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MSEffectUpgardeTextCell.self), for: indexPath) as? MSEffectUpgardeTextCell else {
                fatalError()
            }
            cell.model = dataArray[indexPath.item]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return 104
        } else {
            return 52
        }
    }
}

struct MSEffectUpgradeModel {
    var type: MSEffectUpgradeModelType
    var title: String
    var subTitle: String
    var iconName: String
    var showUnderline: Bool
}
