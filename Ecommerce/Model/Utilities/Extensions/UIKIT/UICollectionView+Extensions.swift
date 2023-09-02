//
//  UICollectionView+Extensions.swift
//  Fenix
//
//  Created by Thinkwink-6 on 29/09/21.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(nibName: String) {
        self.register(.init(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    func checkForNoData(count:Int,strMessage : String,color : UIColor = ColorConstants.WhiteColor , yAxis : Int = -2000 ){
        self.backgroundView = nil;
        if count == 0 {
            var y = 0
            if yAxis != -2000{
                y = yAxis
            }
            let bgView:UIView =  UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width - 15, height: self.bounds.size.height))
            bgView.backgroundColor = .clear
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: CGFloat(0 - y), width: self.bounds.size.width, height: self.bounds.size.height + CGFloat(y)))
            noDataLabel.text          = strMessage
            noDataLabel.textColor     = color
            noDataLabel.textAlignment = .center
            noDataLabel.numberOfLines = 4
            noDataLabel.font = Fonts.sharedObject().getAppFontFont(family: .Medium, size: 16)
            bgView.addSubview(noDataLabel)
            self.backgroundView = bgView
        }else{
            self.backgroundView = nil;
        }
    }
    
//    func checkForNoData(count: Int, message: String, textColor: UIColor = ColorConstants.WhiteColor, backgroundColor: UIColor = .clear, yOffset: CGFloat = 0) {
//        if count == 0 {
//            let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
//            backgroundView.backgroundColor = backgroundColor
//            
//            let messageLabel = UILabel(frame: CGRect(x: 0, y: bounds.midY + yOffset, width: bounds.width, height: 0))
//            messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//            messageLabel.textColor = textColor
//            messageLabel.textAlignment = .center
//            messageLabel.numberOfLines = 0
//            messageLabel.text = message
//            messageLabel.sizeToFit()
//            
//            backgroundView.addSubview(messageLabel)
//            self.backgroundView = backgroundView
//        } else {
//            self.backgroundView = nil
//        }
//    }

}
