//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/13.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    //MARK：空间属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    //MARK:定义模型属性
    var cycleModel : CycleModel? {
        didSet {
           titleLabel.text = cycleModel?.title
            let iconURL = URL(string : cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named:"Img_default"), options:
                nil, progressBlock:nil, completionHandler: nil)
        }
    }

}
