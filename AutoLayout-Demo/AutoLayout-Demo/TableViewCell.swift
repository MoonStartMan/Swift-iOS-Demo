//
//  TableViewCell.swift
//  AutoLayout-Demo
//
//  Created by 王潇 on 2022/12/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private(set) var tableImageView: UIImageView = UIImageView()
    
    private(set) var tableTextLabel: UILabel = UILabel()
    
    var textString: String? {
        didSet {
            if let textString = textString {
                tableTextLabel.text = textString
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(tableImageView)
        tableImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tableTextLabel)
        tableTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let tableImageLeft = NSLayoutConstraint(item: tableImageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 10)
        let tableImageCenterY = NSLayoutConstraint(item: tableImageView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
        let tableImageWidth = NSLayoutConstraint(item: tableImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 24)
        let tableImageHeight = NSLayoutConstraint(item: tableImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 24)
        tableImageView.superview?.addConstraints([tableImageLeft, tableImageCenterY, tableImageWidth, tableImageHeight])
        tableImageView.image = UIImage(named: "icon")
        
        let tableLabelRight = NSLayoutConstraint(item: tableTextLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -10)
        let tableLabelTop = NSLayoutConstraint(item: tableTextLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 10)
        let tableLabelBottom = NSLayoutConstraint(item: tableTextLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -10)
        let tableLabelWidth = NSLayoutConstraint(item: tableTextLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 100)
        tableTextLabel.superview?.addConstraints([tableLabelRight, tableLabelTop, tableLabelBottom, tableLabelWidth])
        tableTextLabel.numberOfLines = 0
        tableTextLabel.textColor = .black
        tableTextLabel.font = .systemFont(ofSize: 12, weight: .bold)
    }
    
}
