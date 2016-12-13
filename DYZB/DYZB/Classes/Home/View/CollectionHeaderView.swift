//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/9.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit


class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK：-定义模型属性
    var group : AnchorGroup?{
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
