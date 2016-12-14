//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/10.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import Foundation

extension Date{
    static func getCurrentTime()->String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        return  "\(interval)"
    }
}
