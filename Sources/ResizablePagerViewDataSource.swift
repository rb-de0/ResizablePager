//
//  ResizablePagerViewDataSource.swift
//  ResizablePager
//
//  Created by rb_de0 on 2017/03/19.
//  Copyright © 2017年 rb_de0. All rights reserved.
//

import UIKit

public protocol ResizablePagerViewDataSource: class {
    func numberOfItems() -> Int
    func resizablePagerView(_ resizablePagerView: ResizablePagerView, viewForAtIndex index: Int) -> ResizableView
}
