//
//  UITextField+Extensions.swift
//  Shotdeck
//
//  Created by Shotdeck_Developer on 11/10/22.
//

import Foundation
import UIKit

extension UITextField {
    
    var placeholderColors: UIColor? {
        get {
            return self.placeholderColors
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    enum Direction
    {
        case Left
        case Right
    }
    
    func setImage(direction:Direction,imageName:String,Frame:CGRect,backgroundColor:UIColor)
    {
        let View = UIView(frame: CGRect(x: Frame.origin.x, y: Frame.origin.y, width: Frame.size.width + 25, height: Frame.size.height))
        View.backgroundColor = backgroundColor
        
        let imageView = UIImageView(frame: Frame)
        imageView.image = UIImage(named: imageName)
        imageView.tintColor = .white
        View.addSubview(imageView)
        if Direction.Left == direction
        {
            self.leftViewMode = .always
            self.leftView = View
        }
        else
        {
            self.rightViewMode = .always
            self.rightView = View
        }
    }
    
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func cornerRadius(){
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    func borderColor(){
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.0
    }
    
    func borderWidth(size:CGFloat){
        self.layer.borderWidth = size
    }
    
    func blank() -> Bool{
        let strTrimmed = self.text!.trim()//get trimmed string
        if(strTrimmed.count == 0)//check textfield is nil or not ,if nil then return false
        {
            return true
        }
        return false
    }
    
    //set begginning space - left space
    func setLeftPadding(paddingValue:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: self.frame.size.height))
        self.leftViewMode = .always
        self.leftView = paddingView
    }
    
    //set end of space
    func setRightPadding(paddingValue:CGFloat){
        let paddingView = UIView(frame: CGRect(x: (self.frame.size.width - paddingValue), y: 0, width: paddingValue, height: self.frame.size.height))
        self.rightViewMode = .always
        self.rightView = paddingView
    }
    
    func setBottomBorder(_ color:UIColor, height:CGFloat) {
        var view = self.viewWithTag(2525)
        if view == nil {
            view = UIView(frame:CGRect(x: 0, y: self.frame.size.height - height, width:  self.frame.size.width, height: 1))
            view?.backgroundColor = color
            view?.tag = 2525
            self .addSubview(view!)
        }
    }
    
    func leftButton(image:UIImage?) {
        let btn = UIButton.init(type: .custom)
        btn.setImage(image, for: .normal)
        btn.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.height, height:  self.frame.size.height)
        self.leftView = btn;
        self.leftViewMode = .always
        // return btn
    }
    
    func modifyClearButtonWithImage(image : UIImage,Uicolor:UIColor) {
        let clearButton = UIButton(type: .custom)
        if #available(iOS 13.0, *) {
            clearButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            clearButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .highlighted)
        } else {
            // Fallback on earlier versions
        }
        clearButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        clearButton.contentMode = .scaleAspectFit
        clearButton.tintColor = Uicolor
        clearButton.imageView?.tintColor = Uicolor
        if clearButton.imageView!.image != nil {
            clearButton.imageView!.image!.withRenderingMode(.alwaysTemplate)
        }
        Common.shared.buttonWithImageTint(btn: clearButton, image: #imageLiteral(resourceName: "ic_close-circle"),Uicolor:Uicolor)
        clearButton.addTarget(self, action: #selector(UITextField.clear(sender:) ), for: .touchUpInside)
        self.rightView = clearButton
        self.rightViewMode = .whileEditing
    }
    
    @objc func clear(sender : AnyObject) {
        self.text = ""
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationKeys.RELOAD_DATA), object: nil)
        sendActions(for: .editingChanged)
    }
    
    
}
