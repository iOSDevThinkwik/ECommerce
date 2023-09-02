//
//  UITableView+Extensions.swift
//  Fenix
//
//  Created by Thinkwink-6 on 29/09/21.
//

import Foundation
import UIKit
import MapKit

extension UITableView {
    
    func register(nibName: String) {
        self.register(.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func checkForNoData(count:Int,strMessage : String,color : UIColor = ColorConstants.WhiteColor, yAxis : Int = -2000 ){
        if count == 0 {
            var y = 0
            if yAxis != -2000{
                y = yAxis
            }
            let bgView:UIView =  UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            bgView.backgroundColor = .clear
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: CGFloat(0 - y), width: self.bounds.size.width, height: self.bounds.size.height + CGFloat(y)))
            noDataLabel.text          = strMessage
            noDataLabel.textColor     = UIColor.white
            noDataLabel.textAlignment = .center
            noDataLabel.numberOfLines = 4
            noDataLabel.font = Fonts.sharedObject().getAppFontFont(family: .Medium, size: 16)
            bgView.addSubview(noDataLabel)
            self.backgroundView = bgView
            self.separatorStyle = .none;
        }else{
            self.backgroundView = nil;
            self.separatorStyle = .none;
        }
    }
    
    func removeBottomSeparatorLine() {
        self.tableFooterView = UIView(frame: CGRect.zero)
        self.separatorStyle = .none
    }

    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
    
    
    
    
}

