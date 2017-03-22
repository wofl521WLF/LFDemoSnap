//
//  UUCell.swift
//  Demo
//
//  Created by 吴林丰 on 2017/3/22.
//  Copyright © 2017年 吴林丰. All rights reserved.
//

import UIKit

class UUCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
         super.init(style: .default, reuseIdentifier: "myCell")
         self.createUI()
    }
    
    func createUI(){
        self.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        let label:UILabel = UILabel()
        label.textColor = UIColor.black
        label.text = "你到底爱不爱我"
        label.textAlignment = .left
        self.contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
             make.left.equalToSuperview().offset(10)
             make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(5)
        }
        
        let view:UIView = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 0.5
        view.layer.backgroundColor = UIColor.white.cgColor
        self.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
        
        let ttFiled:UITextField = UITextField()
        ttFiled.text = "这是一首简单的小情歌"
        ttFiled.textColor = UIColor.red
        ttFiled.isEnabled = false
        ttFiled.textAlignment = .center
        view.addSubview(ttFiled)
        ttFiled.snp.makeConstraints { (make) in
             make.edges.equalToSuperview().inset(UIEdgeInsetsMake(30, 30, 30, 30))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
