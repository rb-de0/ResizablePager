//
//  IndexableTapGestureRecognizer.swift
//  ResizablePager
//
//  Created by rb_de0 on 2017/03/20.
//  Copyright © 2017年 rb_de0. All rights reserved.
//

final class IndexableTapGestureRecognizer: UITapGestureRecognizer {
    
    let index: Int
    
    init(target: Any?, action: Selector?, index: Int) {
        
        self.index = index
        
        super.init(target: target, action: action)
    }
}
