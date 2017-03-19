//
//  ResizablePagerViewDelegate.swift
//  ResizablePager
//
//  Created by rb_de0 on 2017/03/20.
//  Copyright © 2017年 rb_de0. All rights reserved.
//

import UIKit

public protocol ResizablePagerViewDelegate: class {
    
    func resizablePagerView(_ resizablePagerView: ResizablePagerView, didSelectAt index: Int)
}
