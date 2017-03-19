//
//  ResizablePagerView.swift
//  ResizablePager
//
//  Created by rb_de0 on 2017/03/19.
//  Copyright © 2017年 rb_de0. All rights reserved.
//

import UIKit

public class ResizablePagerView: UIView {
    
    // Variable
    public var edgeMargin = CGFloat(80)
    public var verticalMargin = CGFloat(120)
    public var viewMargin = CGFloat(20)
    public var resizeRate = CGFloat(0.7) {
        didSet {
            guard (0...CGFloat(1.0)).contains(resizeRate) else {
                fatalError("resizeRate must be in the range 0...1.0")
            }
        }
    }
    
    public weak var dataSource: ResizablePagerViewDataSource? {
        didSet {
            setupSubviews()
        }
    }
    
    private var adjustedMargin = CGFloat(0)
    private weak var scrollView: UIScrollView!
    
    private var resizableViews: [ResizableView] {
        return scrollView.subviews.flatMap { $0 as? ResizableView }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupScrollView()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layoutScrollView()
    }
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if point.y >= scrollView.frame.origin.y && point.y <= scrollView.frame.origin.y + scrollView.frame.height {
            return scrollView
        }

        return super.hitTest(point, with: event)
    }
    
    // MARK: - Setup
    
    private func setupScrollView() {
        
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.clipsToBounds = false
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        
        addSubview(scrollView)
        
        self.scrollView = scrollView
    }
    
    private func setupSubviews() {
        
        guard let dataSource = dataSource else {
            return
        }
        
        let numberOfItems = dataSource.numberOfItems()
        
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        for idx in 0..<numberOfItems {
            let view = dataSource.resizablePagerView(self, viewForAtIndex: idx)
            view.index = idx
            scrollView.addSubview(view)
        }
        
        layoutSubviews()
    }
    
    // MARK: - Layout
    
    private func layoutScrollView() {
        
        let originalWidth = bounds.width - (edgeMargin - viewMargin) * 2 - viewMargin * 2
        let diffWidth = (originalWidth - originalWidth * resizeRate) / 2
        
        adjustedMargin = (viewMargin - diffWidth) / 2
        
        scrollView.frame = CGRect(
            x: edgeMargin - adjustedMargin,
            y: verticalMargin,
            width: bounds.width - (edgeMargin - adjustedMargin) * 2,
            height: bounds.height - verticalMargin * 2)
        
        for subview in resizableViews.sorted(by: { $0.0.index <  $0.1.index }) {
            
            // reset transform
            subview.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            subview.frame = CGRect(x: CGFloat(subview.index) * scrollView.bounds.width + adjustedMargin,
                                   y: 0,
                                   width: scrollView.bounds.width - adjustedMargin * 2,
                                   height: scrollView.bounds.height)
        }
        
        let max = (resizableViews.map { $0.frame.origin.x + $0.frame.width }.max() ?? 0) + adjustedMargin
        
        scrollView.contentSize = CGSize(width: max, height: scrollView.bounds.height)
        
        updateViews()
    }
    
    fileprivate func updateViews() {
        
        for subview in resizableViews {
            
            subview.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            let diff = fabs(subview.frame.origin.x - adjustedMargin - scrollView.contentOffset.x)
            let percent = diff / scrollView.bounds.width
            
            if percent >= 1.0 {
                subview.transform = CGAffineTransform(scaleX: resizeRate, y: resizeRate)
            } else {
                subview.transform = CGAffineTransform(scaleX: 1 - (1 - resizeRate) * percent, y: 1 - (1 - resizeRate) * percent)
            }
        }
    }
}

// MARK: - UIScrollViewDelegate
extension ResizablePagerView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateViews()
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateViews()
    }
}
