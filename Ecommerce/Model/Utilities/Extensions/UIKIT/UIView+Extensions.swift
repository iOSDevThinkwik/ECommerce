//
//  UIView+Extensions.swift
//  Fenix
//
//  Created by Thinkwink-6 on 08/09/21.
//

import Foundation
import UIKit

extension UIView {
    
    func applyGredientBG(colors: [UIColor], locations: [NSNumber] = [NSNumber](), points: [CGPoint] = [CGPoint](), isCenter: Bool = true) {
        let gl = CAGradientLayer()
        gl.colors = colors.map {$0.cgColor}
        
        if points.count == 2 {
            gl.startPoint = points.first!
            gl.startPoint = points.last!
        }
        gl.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 1, c: -1, d: 1, tx: 0, ty: 0))

        if locations.count > 1 {
            gl.locations = locations
        }
        else {
            gl.locations = [0, 1]
        }
        gl.bounds = self.bounds.insetBy(dx: -0.5 * self.bounds.size.width, dy: -0.5 * self.bounds.size.height)
//        gl.bounds = self.bounds

        if isCenter == true {
            gl.position = self.center
        }
        self.layer.insertSublayer(gl, at: 0);
//        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    
    func applyGradient(colors: [UIColor], points: [CGPoint] = [CGPoint]()) {
//        self.removeGredient()
        let gl = CAGradientLayer()
        gl.colors = colors.map {$0.cgColor}
        gl.locations = [0, 1]
        if points.count == 2 {
            gl.startPoint = points.first!
            gl.endPoint = points.last!
        }
        gl.frame = self.bounds
        self.layer.insertSublayer(gl, at: 0);
    }
    
    func setGredientBorder(gredientColor: [UIColor], lineWidth: CGFloat, strokeColor: UIColor, fillColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
//        gradient.frame =  self.frame.insetBy(dx: -lineWidth, dy: -lineWidth)
        
        gradient.colors = gredientColor.map({ color in color.cgColor })
//        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 1, c: -1, d: 1, tx: 0, ty: 0))
        gradient.startPoint = .init(x: 0, y: 0)
        gradient.endPoint = .init(x: 1, y: 0)
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
//        shape.path = UIBezierPath(rect: self.bounds).cgPath
        shape.path = UIBezierPath(roundedRect: self.frame, cornerRadius: self.frame.width / 2).cgPath
        shape.strokeColor = strokeColor.cgColor
        shape.fillColor = fillColor.cgColor
        gradient.mask = shape
        self.layer.addSublayer(gradient)
    }
    
    
    func removeGredient() {
        if self.layer.sublayers?.count == nil {
            return
        }
        
        for gredientLayer in self.layer.sublayers! {
            if gredientLayer.isKind(of: CAGradientLayer.classForCoder()) {
                gredientLayer.removeFromSuperlayer()
                break;
            }
        }
    }
    
    func makeRounded(borderColor: UIColor = UIColor.clear, borderWidth: CGFloat = 0) {
        self.setCornerRadius(cornerRadius: self.frame.height / 2, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    func setCornerRadius(cornerRadius: CGFloat, borderColor: UIColor = UIColor.clear, borderWidth: CGFloat = 0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func removeRoundCorners() {
        layer.mask = nil
    }
    
    func removeCornderRadius() {
        self.layer.borderWidth = 0
    }
    
    func addTapGesture(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTapOfView(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTapOfView(_ sender: MyTapGestureRecognizer) {
        if sender.action != nil {
            sender.action!()
        }
    }
    
    func fadeTransitionnnnn(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    

    static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 1) {
        DispatchQueue.main.async {
            if self.layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
                let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
                
                rotationAnimation.fromValue = Float.pi
                rotationAnimation.toValue = Double.pi * 3.0
                rotationAnimation.duration = duration
                rotationAnimation.repeatCount = Float.infinity
                self.layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
            }
        }

    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func setTintColor(color: UIColor) {
        let states: [UIControl.State] = [.normal, .selected]
        if self.isKind(of: UIButton.classForCoder()) {
            
            let btn = self as! UIButton
            for state in states {
                if let img = btn.image(for: state) {
                    btn.setImage(img.withRenderingMode(.alwaysTemplate), for: state)
                }
            }
        }
        else if self.isKind(of: UIImageView.classForCoder()) {
            let imgView = self as! UIImageView
            if let img = imgView.image {
                imgView.image = img.withRenderingMode(.alwaysTemplate)
            }
        }
        self.tintColor = color
    }
}
class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}
extension CAGradientLayer {
    enum Point {
        case topLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case centerRight
        case bottomRight
        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}





extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

extension UIView{
    
    func makeRounded() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    public func removeAllConstraints() {
        var _superview = self.superview
        
        while let superview = _superview {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            _superview = superview.superview
        }
        
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.5
        }, completion: nil)
    }
    
    func constrainCentered(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0)
        
        let horizontalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0)
        
        let heightContraint = NSLayoutConstraint(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.height)
        
        let widthContraint = NSLayoutConstraint(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.width)
        
        addConstraints([
            horizontalContraint,
            verticalContraint,
            heightContraint,
            widthContraint])
    }
    
    func constrainToEdges(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
    
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }else {
            return self.leftAnchor
        }
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }else {
            return self.rightAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview()}
    }
    
    @IBInspectable var Corneredius:CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var BorderWidth:CGFloat{
        get{
            return layer.borderWidth
        }
        set{
            self.layer.borderWidth = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var TWBorderColor:UIColor{
        get{
            return self.TWBorderColor
        }
        set{
            self.layer.borderColor = newValue.cgColor
            
        }
    }
    
    var TWRoundDynamic:Bool{
        get{
            return false
        }
        set{
            if newValue == true {
                
                self.perform(#selector(UIView.afterDelay), with: nil, afterDelay: 0.1)
            }
        }
    }
    
    @objc func afterDelay(){
        let  Height =  self.frame.size.height
        self.layer.cornerRadius = Height/2;
        self.layer.masksToBounds = true;
    }
    
    var TWRound:Bool{
        get{
            return false
        }
        set{
            if newValue == true {
                self.layer.cornerRadius = self.frame.size.height/2;
                self.layer.masksToBounds = true;
            }
        }
    }
    
    var TWShadow:Bool{
        get{
            return false
        }
        set{
            if newValue == true {
                self.layer.masksToBounds = false
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
                self.layer.shadowOpacity = 0.6;
            }
        }
    }
    
    var TWclipsToBounds:Bool{
        get{
            return false
        }
        set{
            if newValue == true {
                
                self.clipsToBounds = true;
            }else{
                self.clipsToBounds = false
            }
        }
    }
    
    func shadowWithcell() {
        self.layer.masksToBounds = false
        //self.layer.shadowColor = color.lightGray.value.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height:0.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 6.0
    }
    
    func shadowBotton(alph:Float){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = alph
    }
    
    func shadowWith(alph:Float){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = alph
    }
    
    func shadowBottom(alph:Float){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 0)
        self.layer.shadowOpacity = alph
    }
    
    func addShadowProfile(to edges:[UIRectEdge], radius:CGFloat,toColor : UIColor){
        
        //  let fromColor = CGColor.lightGray.value
        let toColor = toColor
        
        // Set up its frame.
        let viewFrame = self.frame
        for edge in edges{
            let gradientlayer          = CAGradientLayer()
            gradientlayer.colors       = [toColor.cgColor,toColor.cgColor]
            gradientlayer.shadowRadius = radius
            switch edge {
            case UIRectEdge.top:
                gradientlayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientlayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientlayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: gradientlayer.shadowRadius)
            case UIRectEdge.bottom:
                gradientlayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientlayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientlayer.frame = CGRect(x: 0.0, y: viewFrame.height - gradientlayer.shadowRadius, width: viewFrame.width, height: gradientlayer.shadowRadius)
            case UIRectEdge.left:
                gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientlayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientlayer.frame = CGRect(x: 0.0, y: 0.0, width: gradientlayer.shadowRadius, height: viewFrame.height)
            case UIRectEdge.right:
                gradientlayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientlayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientlayer.frame = CGRect(x: viewFrame.width - gradientlayer.shadowRadius, y: 0.0, width: gradientlayer.shadowRadius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientlayer)
        }
    }
    func addButtonShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    
    func addShadow(to edges:[UIRectEdge], radius:CGFloat,toColor : UIColor){
        
        let fromColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        let toColor = toColor
        
        // Set up its frame.
        let viewFrame = self.frame
        for edge in edges{
            let gradientlayer          = CAGradientLayer()
            gradientlayer.colors       = [fromColor.cgColor,toColor.cgColor]
            gradientlayer.shadowRadius = radius
            switch edge {
            case UIRectEdge.top:
                gradientlayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientlayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientlayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: gradientlayer.shadowRadius)
            case UIRectEdge.bottom:
                gradientlayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientlayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientlayer.frame = CGRect(x: 0.0, y: viewFrame.height - gradientlayer.shadowRadius, width: viewFrame.width, height: gradientlayer.shadowRadius)
            case UIRectEdge.left:
                gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientlayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientlayer.frame = CGRect(x: 0.0, y: 0.0, width: gradientlayer.shadowRadius, height: viewFrame.height)
            case UIRectEdge.right:
                gradientlayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientlayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientlayer.frame = CGRect(x: viewFrame.width - gradientlayer.shadowRadius, y: 0.0, width: gradientlayer.shadowRadius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientlayer)
        }
    }

    func setGradientTheme()
    {
        
        let color1 = UIColor()
        let color2 = UIColor()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [0.5 , 0.5] //here you can set percentage of color part are display betwin 0 to 1
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addSubviews(views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
       
}
extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
