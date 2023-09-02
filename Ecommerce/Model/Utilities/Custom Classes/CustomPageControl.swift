//
//  CustomPageControl.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 23/05/23.
//

import Foundation
import UIKit

class CustomPageControl: UIPageControl {
    
    var customPageIndicatorImage: UIImage?
    var customCurrentPageIndicatorImage: UIImage?
    
    override var currentPage: Int {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        // Calculate the frame for each page indicator
        let indicatorWidth: CGFloat = 6
        let indicatorHeight: CGFloat = 6
        let spacing: CGFloat = 5
        let totalWidth = (CGFloat(numberOfPages) * indicatorWidth) + (indicatorWidth * 2) + CGFloat(numberOfPages - 1) * spacing
        //var x = (bounds.width - totalWidth) / 2
        var x: CGFloat = 32
        let y = (bounds.height - indicatorHeight) / 2

        // Draw the custom images for each page indicator
        
        for i in 0..<numberOfPages {
            var indicatorFrame: CGRect?
            if self.currentPage == i {
                let width = indicatorWidth * 2
                indicatorFrame = CGRect(x: x, y: y, width: width, height: indicatorHeight)
                x += (indicatorWidth * 1.1)
            }
            else {
                indicatorFrame = CGRect(x: x, y: y, width: indicatorWidth, height: indicatorHeight)
            }
            let indicatorImage = i == currentPage ? customCurrentPageIndicatorImage : customPageIndicatorImage
            UIView.animate(withDuration: 0.3) {
                indicatorImage?.draw(in: indicatorFrame!)
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
            x += indicatorWidth + spacing
        }
    }
}

