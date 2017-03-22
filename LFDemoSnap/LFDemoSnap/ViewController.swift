//
//  ViewController.swift
//  Demo
//
//  Created by 吴林丰 on 2017/3/22.
//  Copyright © 2017年 吴林丰. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    lazy var disPlayView:UITableView = {
        let tt:UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tt.delegate = self
        tt.dataSource = self
        return tt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.example1()
        
        //self.example2()
        
        //self.example3()
        
        self.example4()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // MARK: - 简单示例
    func example1() {
        let uv:UIView = UIView()
        uv.backgroundColor = UIColor.red
        self.view.addSubview(uv)
        uv.snp.makeConstraints { (make) in
            // make.center.equalTo(self.view)
             make.center.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 300, height: 300))
        }
        
        let uv1:UIView = UIView()
        uv1.backgroundColor = UIColor.yellow
        uv.addSubview(uv1)
        uv1.snp.makeConstraints { (make) in
            make.edges.equalTo(uv).inset(UIEdgeInsetsMake(10, 10, 10, 10))
           /**  
            make.top.equalTo(uv.snp.top).offset(10)
            make.left.equalTo(uv.snp.left).offset(10)
            make.right.equalTo(uv.snp.right).offset(-10)
            make.bottom.equalTo(uv.snp.bottom).offset(-10)
            */
        }
        
        let uv2:UIView = UIView()
        let uv3:UIView = UIView()
        uv2.backgroundColor = UIColor.green
        uv3.backgroundColor = UIColor.green
        uv1.addSubview(uv2)
        uv1.addSubview(uv3)
        let padding:Int = 10
        uv2.snp.makeConstraints { ( make) in
             make.left.equalToSuperview().offset(padding)
             make.right.equalTo(uv3.snp.left).offset(-padding)
             make.centerY.equalTo(uv1.snp.centerY)
             make.height.equalTo(150)
             make.width.equalTo(uv3.snp.width)
        }
        
        uv3.snp.makeConstraints { (make) in
            make.left.equalTo(uv2.snp.right).offset(padding)
            make.right.equalTo(uv1.snp.right).offset(-padding)
            make.height.equalTo(150)
            make.centerY.equalTo(uv1.snp.centerY)
            make.width.equalTo(uv2.snp.width)
        }
        
        
        
    }
    
    // MARK: -- scrollView 示例
    func example2(){
        let uv:UIView = UIView()
        uv.backgroundColor = UIColor.yellow
        self.view.addSubview(uv)
        uv.snp.makeConstraints { (make) in
            // make.center.equalTo(self.view)
            make.center.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 300, height: 400))
        }
        
        let scview:UIScrollView = UIScrollView()
        scview.backgroundColor = UIColor.white
        uv.addSubview(scview)
        
        scview.snp.makeConstraints { (make) in
            make.edges.equalTo(uv).inset(UIEdgeInsetsMake(5, 5, 5, 5))
        }
        
        let containtView:UIView = UIView()
        scview.addSubview(containtView)
        containtView.snp.makeConstraints { (make) in
             make.edges.equalToSuperview()
             make.width.equalToSuperview()
        }
        
        var lastView:UIView? = nil
        for i in 0..<10{
            let subView:UIView = UIView()
            containtView.addSubview(subView)
            subView.backgroundColor = UIColor.init(hue: CGFloat(arc4random() % 256), saturation: CGFloat(arc4random() % 128)/256.0+CGFloat(i/10), brightness: CGFloat(arc4random() % 128)/256.0 + CGFloat(i/10), alpha: CGFloat(1))
            subView.snp.makeConstraints({ (make) in
                 make.left.right.equalToSuperview()
                 make.height.equalTo(20*i)
                if lastView != nil{
                    make.top.equalTo(lastView!.snp.bottom)
                }else{
                    make.top.equalTo(containtView.snp.top)
                }
            })
            lastView = subView
        }
        
        containtView.snp.makeConstraints { (make) in
             make.bottom.equalTo(lastView!.snp.bottom)
        }
    }
    
    
    // MARK: -- 计算器示例
    func example3() {
        //先布局显示View 
        let showview:UIView = UIView()
        showview.backgroundColor = UIColor.black
        self.view.addSubview(showview)
        
        //接着声明键盘区域
        let keyBoardView = UIView()
        keyBoardView.backgroundColor = UIColor.gray
        self.view.addSubview(keyBoardView)
        
        //接着进行布局
        showview.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(keyBoardView).multipliedBy(0.3)
        }
        
        keyBoardView.snp.makeConstraints { (make) in
            
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.top.equalTo(showview.snp.bottom)
        }
        
        let textLabel:UILabel = UILabel()
        textLabel.text = "0"
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .right
        textLabel.font = UIFont.systemFont(ofSize: 70)
        showview.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(100)
        }
        
        let arr = ["AC","+/-","%","÷"
            ,"7","8","9","x"
            ,"4","5","6","-"
            ,"1","2","3","+"
            ,"0","?",".","="]
        var indexOfKeys = 0
        for i in arr{
            indexOfKeys += 1
            let rowNum = indexOfKeys % 4 == 0 ? indexOfKeys/4 : indexOfKeys/4+1
            let colNum = indexOfKeys % 4 == 0 ? 4 : indexOfKeys % 4
            
            let button:UIButton = UIButton.init(type: .custom)
            keyBoardView.addSubview(button)
            button.setTitle(i, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.blue
            button.layer.borderWidth = 0.5
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            
            //布局
            button.snp.makeConstraints({ ( make) in
                if i == "0" || i == "?"{
                    if i == "0"{
                        make.height.equalTo(keyBoardView.snp.height).multipliedBy(0.2)
                        make.width.equalTo(keyBoardView.snp.width).multipliedBy(0.5)
                        make.left.equalToSuperview()
                        make.lastBaseline.equalTo(keyBoardView.snp.lastBaseline).multipliedBy(0.9)
                    }else{
                        button.removeFromSuperview()
                    }
                }else{
                    
                    make.width.equalTo(keyBoardView.snp.width).multipliedBy(0.25)
                    make.height.equalTo(keyBoardView.snp.height).multipliedBy(0.2)
                    switch colNum{
                        
                    case 1:
                    make.left.equalToSuperview()
                    case 2:
                    make.right.equalTo(keyBoardView.snp.centerX)
                    case 3:
                    make.left.equalTo(keyBoardView.snp.centerX)
                    case 4:
                    make.right.equalToSuperview()
                    default : break
                    }
                    switch rowNum{
                    
                    case 1:
                    make.lastBaseline.equalTo(keyBoardView.snp.lastBaseline).multipliedBy(0.1)
                    case 2:
                    make.lastBaseline.equalTo(keyBoardView.snp.lastBaseline).multipliedBy(0.3)
                    case 3:
                    make.lastBaseline.equalTo(keyBoardView.snp.lastBaseline).multipliedBy(0.5)
                    case 4:
                    make.lastBaseline.equalTo(keyBoardView.snp.lastBaseline).multipliedBy(0.7)
                    case 5:
                    make.lastBaseline.equalTo(keyBoardView.snp.lastBaseline).multipliedBy(0.9)
                    default : break
                    }
                }
            })
        
        }
    }
    
    func example4(){
        let headView:UIView = UIView()
        self.view.addSubview(headView)
        headView.backgroundColor = UIColor.orange
        headView.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(64)
        }
        
        let btn1:UIButton = UIButton.init(type: .custom)
        btn1.backgroundColor = UIColor.red
        headView.addSubview(btn1)
        btn1.snp.makeConstraints { (make) in
            
            make.bottom.equalTo(headView.snp.bottom).offset(-10)
            make.left.equalTo(headView.snp.left).offset(10)
            make.size.equalTo(CGSize.init(width: 20, height: 30))
        }
        
        let label:UILabel = UILabel()
        label.text = "返回"
        label.textColor = UIColor.white
        label.textAlignment = .left
        headView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(btn1.snp.right).offset(10)
            make.centerY.equalTo(btn1.snp.centerY)
            make.size.equalTo(CGSize.init(width: 100, height: 20))
        }
        
        let label2:UILabel = UILabel()
        label2.textAlignment = .right
        label2.textColor = UIColor.white
        label2.text = "详情"
        headView.addSubview(label2)
        
        label2.snp.makeConstraints { (make) in
            make.right.equalTo(headView.snp.right).offset(-10)
            make.centerY.equalTo(label.snp.centerY)
            make.size.equalTo(label.snp.size)
        }
        
        let imgView:UIImageView = UIImageView()
        imgView.image = UIImage.init(named: "abcd")
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
        self.view.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.equalTo(self.view.snp.left).offset(10)
            make.size.equalTo(CGSize.init(width: 80, height: 80))
        }
        
        let label3:UILabel = UILabel()
        label3.text = "I'm  back ✨"
        label3.textColor = UIColor.red
        label3.backgroundColor = UIColor.green
        label3.textAlignment = .right
        self.view.addSubview(label3)
        
        label3.snp.makeConstraints { (make) in
            make.centerY.equalTo(imgView.snp.centerY)
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.size.equalTo(CGSize.init(width: 150, height: 60))
        }
        
        self.view.addSubview(self.disPlayView)
        self.disPlayView.snp.makeConstraints { (make) in
             make.top.equalTo(imgView.snp.bottom).offset(10)
             make.left.right.equalToSuperview()
             make.bottom.equalToSuperview()
        }
 
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tt:String = "myCell"
        var cell:UUCell? = tableView.dequeueReusableCell(withIdentifier: tt) as? UUCell
        if cell == nil {
             cell = UUCell.init(style: .default, reuseIdentifier: tt)
        }
        cell?.selectionStyle = .none
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

