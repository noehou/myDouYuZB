//
//  BaseGameModel.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/13.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    //MARK：-定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    //MARK：-构造函数
    override init() {
        
    }
    
    
    //MARK:-自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
