//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/9.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    @IBOutlet weak var roomNameLabel: UILabel!
   
    
    
    //MARK：--定义模型属性
   override var anchor : AnchorModel? {
        didSet{
            super.anchor = anchor
            roomNameLabel.text = anchor?.roomName
        }
    }
}
