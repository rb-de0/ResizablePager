//
//  ContentView.swift
//  ResizablePager
//
//  Created by rb_de0 on 2017/03/20.
//  Copyright © 2017年 rb_de0. All rights reserved.
//

import UIKit
import ResizablePager

class ContentView: ResizableView {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    func configure(with color: UIColor) {
        imageView.backgroundColor = color
    }
}
