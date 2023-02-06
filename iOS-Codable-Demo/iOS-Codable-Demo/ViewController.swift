//
//  ViewController.swift
//  iOS-Codable-Demo
//
//  Created by 王潇 on 2023/1/30.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    private var contentView: UIView = UIView()
    
    private var titleLabel: UILabel = UILabel()
    
    private var imageView: UIImageView = UIImageView()
    
    private var cateGoryLabel: UILabel = UILabel()
    
    private var tagsLabel: UILabel = UILabel()
    
    private var statusLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getDataList { [weak self] dataList in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.setupView(model: dataList)
            }
        }
        
    }
    
    func setupView(model: Pet) {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-200)
        }
        contentView.backgroundColor = .systemPink
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(20)
        }
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .hex("#000000")
        titleLabel.text = "ID: \(model.data.id)"
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.layoutIfNeeded()
        
        if let url = URL(string: model.data.photoUrls[0]) {
            imageView.kf.setImage(with: url, placeholder: nil, options: nil)
        }
        
        contentView.addSubview(cateGoryLabel)
        cateGoryLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.left.equalTo(20)
        }
        cateGoryLabel.font = .systemFont(ofSize: 14, weight: .black)
        cateGoryLabel.textColor = .hex("#000000")
        cateGoryLabel.text = "Category\nID: \(model.data.category.id)   NAME: \(model.data.category.name)"
        cateGoryLabel.numberOfLines = 0
        
        contentView.addSubview(tagsLabel)
        tagsLabel.snp.makeConstraints { make in
            make.top.equalTo(cateGoryLabel.snp.bottom).offset(10)
            make.left.equalTo(20)
        }
        tagsLabel.font = .systemFont(ofSize: 14, weight: .black)
        tagsLabel.textColor = .hex("#000000")
        tagsLabel.text = "Tags\nID: \(model.data.tags[0].id)   NAME: \(model.data.tags[0].name)"
        tagsLabel.numberOfLines = 0
        
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(tagsLabel.snp.bottom).offset(10)
            make.left.equalTo(20)
        }
        statusLabel.font = .systemFont(ofSize: 14, weight: .black)
        statusLabel.textColor = .hex("#000000")
        statusLabel.text = "STATUS: \(model.data.status)"
    }
}


/// 获取数据
extension ViewController {
    func getDataList(completion: @escaping (_ dataList: Pet) -> Void) {
        if findFileExist(path: "model") {
            print("------>文件已存在")
            /// 已经存在直接解档
            do {
                guard let pathString = getDocumentsPath(path: "model") else {
                    return
                }
                let url = URL(fileURLWithPath: pathString)
                let data = try Data(contentsOf: url)
                let model = try JSONDecoder().decode(Pet.self, from: data)
                    completion(model)
            } catch {
                print("解档失败")
            }
        } else {
            print("------>文件不存在")
            /// 下载并存储
            Request.request.getData(url: "https://mock.apifox.cn/m1/2226978-0-default/pet/1", methond: .get, dataType: Pet.self) { dataList in
                completion(dataList)
                /// 归档
                do {
                    let storageData = try JSONEncoder().encode(dataList)
                    try storageData.write(to: URL(fileURLWithPath: self.getDocumentsPath(path: "model")!))
                } catch {
                    print(error)
                }
            }
        }
    }

    /// 获取文件路径
    func getDocumentsPath(path: String) -> String? {
        let docPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first as NSString?
        let filePath = docPath?.appendingPathComponent(path)
        return filePath
    }

    /// 查找文件是否存在
    func findFileExist(path: String) -> Bool {
        let docPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first as NSString?
        let filePath = docPath?.appendingPathComponent(path)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath ?? "") {
            return true
        } else {
            return false
        }
    }
}
