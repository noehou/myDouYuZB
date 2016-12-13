//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/12.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onLineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet {
            //0、校验模型是否有值
            guard let anchor = anchor else {return}
            
            //1、取出在线人数显示文字
            var onLineStr : String = ""
            if anchor.online >= 10000 {
                onLineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onLineStr = "\(anchor.online)在线"
            }
            onLineBtn.setTitle(onLineStr, for: .normal)
            
            //2、昵称的显示
            nickNameLabel.text = anchor.nickName
            
            
            //4、设置封面图片
            guard let iconURL = URL(string:anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: iconURL)
            
        }
    }
}
