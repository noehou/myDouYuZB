//
//  UIBarButtonitem-Extension.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/8.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
//    class func createItem(imageName:String,highImageName:String,size:CGSize)-> UIBarButtonItem{
//        let btn = UIButton()
//        
//        btn.setImage(UIImage(named:imageName), for:.normal)
//        btn.setImage(UIImage(named:highImageName), for: .highlighted)
//        
//        btn.frame = CGRect(origin:.zero,size:size)
//        return UIBarButtonItem(customView: btn)
//    }
    
    
    convenience init(imageName:String,highImageName:String = "",size:CGSize = .zero) {
                let btn = UIButton()
                btn.setImage(UIImage(named:imageName), for:.normal)
                if highImageName != ""{
                     btn.setImage(UIImage(named:highImageName), for: .highlighted)
                }
        
                if size == .zero {
                    btn.sizeToFit()
                }else{
                    btn.frame = CGRect(origin:.zero,size:size)
                }
        
                self.init(customView: btn)
    }
}
