//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/9.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    @IBOutlet weak var cityBtn: UIButton!
    
    //MARK：--定义模型属性
  override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            //所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

}
