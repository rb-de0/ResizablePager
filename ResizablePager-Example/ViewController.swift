//
//  ViewController.swift
//  ResizablePager
//
//  Created by rb_de0 on 2017/03/19.
//  Copyright © 2017年 rb_de0. All rights reserved.
//

import UIKit
import ResizablePager

class ViewController: UIViewController {
    
    @IBOutlet private weak var pagerView: ResizablePagerView!
    
    fileprivate var contents: [UIColor] = [
        .blue,
        .red,
        .yellow,
        .green,
        .black
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagerView.resizeRate = 0.85
        pagerView.edgeMargin = 80
        pagerView.verticalMargin = 120
        pagerView.viewMargin = 30
        
        pagerView.delegate = self
        pagerView.dataSource = self
    }
}

// MARK: - ResizablePagerViewDataSource
extension ViewController: ResizablePagerViewDataSource {
    
    func numberOfItems() -> Int {
        return contents.count
    }
    
    func resizablePagerView(_ resizablePagerView: ResizablePagerView, viewForAtIndex index: Int) -> ResizableView {
        let view = UINib(nibName: "ContentView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ContentView
        view.configure(with: contents[index])
        return view
    }
}

// MARK: - ResizablePagerViewDelegate
extension ViewController: ResizablePagerViewDelegate {

    func resizablePagerView(_ resizablePagerView: ResizablePagerView, didSelectAt index: Int) {
        print(index)
    }
}
