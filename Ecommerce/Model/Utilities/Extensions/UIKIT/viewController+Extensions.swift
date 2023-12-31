//
//  viewController+Extensions.swift
//  SHOTDECK
//
//  Created by HEMANG SOLANKI on 10/10/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showToast(message : String, font: UIFont = Fonts.sharedObject().getAppFontFont(family: .Regular, size: 16),isMenu:Bool = true, isAttributed:Bool = false ,deckName:String? = nil, onTapAction: ((Bool) -> Void)? = nil) {
        let viewToast = UIView.init()
        var isCompeletedTask = false
        viewToast.tag = -1904
        viewToast.backgroundColor = .clear
        viewToast.translatesAutoresizingMaskIntoConstraints = false
//        viewToast.layer.cornerRadius = 10;
//        viewToast.clipsToBounds  =  true
//        viewToast.alpha = 1.0
        if let taglist = self.view.viewWithTag(-1904){
            taglist.isHidden = true
            taglist.removeFromSuperview()
        }
        self.view.addSubview(viewToast)
        
        var bottomValue = -50
        
        if isMenu {
            bottomValue = -140
        }else{
            bottomValue = -80
        }
        
        if isiPad() {
            bottomValue = -140
        }
        
        let bottomConst = NSLayoutConstraint.init(item: viewToast as Any, attribute: .bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .bottom, multiplier: 1, constant: CGFloat(bottomValue))
        let leadingConst = NSLayoutConstraint.init(item: viewToast as Any, attribute: .leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .leading, multiplier: 1, constant: 60)
        let trailingConst = NSLayoutConstraint.init(item: viewToast as Any, attribute: .trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -60)
        self.view.addConstraint(leadingConst)
        self.view.addConstraint(trailingConst)
        self.view.addConstraint(bottomConst)
        self.view.layoutSubviews()
        
        let viewBg = UIView()
        viewBg.backgroundColor = ColorConstants.WhiteColor.withAlphaComponent(1)
        viewBg.translatesAutoresizingMaskIntoConstraints = false
        viewBg.layer.cornerRadius = 10;
        viewBg.clipsToBounds  =  true
        viewBg.alpha = 1.0
        viewToast.addSubview(viewBg)
        
        let viewBgTopConst = NSLayoutConstraint.init(item: viewBg as Any, attribute: .top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .top, multiplier: 1, constant: 0)
        let viewBgBottomConst = NSLayoutConstraint.init(item: viewBg as Any, attribute: .bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .bottom, multiplier: 1, constant: 0)
        let viewBgLeadingConst = NSLayoutConstraint.init(item: viewBg as Any, attribute: .leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .leading, multiplier: 1, constant: 0)
        let viewBgTrailingConst = NSLayoutConstraint.init(item: viewBg as Any, attribute: .trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .trailing, multiplier: 1, constant: 0)
        
        viewToast.addConstraints([viewBgTopConst, viewBgBottomConst, viewBgLeadingConst, viewBgTrailingConst])
        
        let toastLabel = UILabel()
        toastLabel.textColor = ColorConstants.BlackColor
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        if isAttributed == true {
            let stringValue = "\(message)"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
            attributedString.setColorForText(textForAttribute: " \(deckName ?? "")", withColor: ColorConstants.BlueThemeColor!)
            attributedString.setFont(textForAttribute: " \(deckName ?? "")", withFont: Fonts.sharedObject().getAppFontFont(family: .Medium, size: 16))
            
            attributedString.setColorForText(textForAttribute: "\(message):", withColor: ColorConstants.BlackColor!)
            attributedString.setFont(textForAttribute: "\(message):", withFont: font)
        
            toastLabel.attributedText = attributedString
        }else {
            toastLabel.text = message
        }
        
        toastLabel.numberOfLines = 0
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        viewToast.addSubview(toastLabel)
        
        let labelTopConst = NSLayoutConstraint.init(item: toastLabel as Any, attribute: .top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .top, multiplier: 1, constant: 10)
        let labelBottomConst = NSLayoutConstraint.init(item: toastLabel as Any, attribute: .bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .bottom, multiplier: 1, constant: -10)
        let labelLeadingConst = NSLayoutConstraint.init(item: toastLabel as Any, attribute: .leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .leading, multiplier: 1, constant: 20)
        let labelTrailingConst = NSLayoutConstraint.init(item: toastLabel as Any, attribute: .trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewToast, attribute: .trailing, multiplier: 1, constant: -20)
        
        viewToast.addConstraints([labelTopConst, labelBottomConst, labelLeadingConst, labelTrailingConst])
        toastLabel.addTapGesture {
            isCompeletedTask = true
            if onTapAction != nil {
                onTapAction?(isCompeletedTask)
            }
            viewToast.removeFromSuperview()
        }
        self.view.layoutSubviews()
        UIView.animate(withDuration: 1.0, delay: 3, options: .curveEaseOut, animations: {
            viewBg.alpha = 0.0
        }, completion: {
            (isCompleted) in
            viewToast.removeFromSuperview()
        })
    }
    
    func hideKeyboardTappedAround() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing (true)
    }
    
    func makePullToRefreshToCollectionView(collectionView: UICollectionView, triggerMethod: Selector){
        let collectionRefreshControl:UIRefreshControl = UIRefreshControl()
        collectionRefreshControl.backgroundColor = UIColor.clear
        collectionRefreshControl.addTarget(self, action: triggerMethod, for: UIControl.Event.valueChanged)
        collectionView.refreshControl = collectionRefreshControl
    }
    
    func endRefreshing(collectionView: UICollectionView){
        collectionView.refreshControl?.endRefreshing()
    }
    
    func makePullToRefreshToTableView(tableView: UITableView, triggerMethod: Selector){
        let tableRefreshControl:UIRefreshControl = UIRefreshControl()
        tableRefreshControl.backgroundColor = UIColor.clear
        tableRefreshControl.tintColor = ColorConstants.BlueThemeColor
        tableRefreshControl.addTarget(self, action: triggerMethod, for: UIControl.Event.valueChanged)
        tableView.refreshControl = tableRefreshControl
    }
    
    func endRefreshing(tableView: UITableView){
        tableView.refreshControl?.endRefreshing()
    }
    
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = .red
        let someAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(someAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func bindKeyboard(to constraint: NSLayoutConstraint) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { [weak self, weak constraint] notification in
            guard let info = notification.userInfo else { return }
            guard let height = (info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height else { return }
            guard constraint?.constant != height else { return }
            constraint?.constant = height + 5
            self?.view.layoutIfNeeded()
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) { [weak self, weak constraint] notification in
            guard constraint?.constant != 0 else { return }
            guard let info = notification.userInfo else { return }
            guard ((info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height) != nil else { return }
            constraint?.constant = 20
            self?.view.layoutIfNeeded()
        }
    }
    
    func hideNavigationBar(){
        self.navigationController?.navigationBar.isHidden = true
    }
    
}
extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
    func setFont(textForAttribute: String, withFont font: UIFont) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        
        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
    
}
extension Range where Bound == String.Index {
    
    var nsRange:NSRange {
        return NSRange(location: self.lowerBound.encodedOffset,
                       length: self.upperBound.encodedOffset -
                       self.lowerBound.encodedOffset)
    }
    
}
