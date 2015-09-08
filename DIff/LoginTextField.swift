//
//  LoginTextField.swift
//  
//
//  Created by SkyArrow on 2015/9/8.
//
//

import UIKit

@IBDesignable class LoginTextField: UITextField {
    var titleLabel = UILabel()
    var errorLabel = UILabel()
    var underline = CAShapeLayer()
    
    @IBInspectable var title: String? {
        didSet {
            titleLabel.text = title
            titleLabel.sizeToFit()
        }
    }
    
    @IBInspectable var error: String? {
        didSet {
            errorLabel.text = error
            errorLabel.sizeToFit()
        }
    }
    
    override var accessibilityLabel: String! {
        get {
            if text.isEmpty {
                return titleLabel.text
            } else {
                return text
            }
        }
        set {
            self.accessibilityLabel = newValue
        }
    }
    
    @IBInspectable var labelFont: UIFont = UIFont.systemFontOfSize(12) {
        didSet {
            titleLabel.font = labelFont
            titleLabel.sizeToFit()
            
            errorLabel.font = labelFont
            errorLabel.sizeToFit()
        }
    }
    
    @IBInspectable var labelColor: UIColor = UIColor(white: 0.8, alpha: 1) {
        didSet {
            titleLabel.textColor = labelColor
        }
    }
    
    @IBInspectable var errorColor: UIColor = UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1) {
        didSet {
            errorLabel.textColor = errorColor
        }
    }
    
    @IBInspectable var highlightedColor: UIColor = UIColor(red: 0/255, green: 188/255, blue: 212/255, alpha: 1) {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor(white: 0.4, alpha: 1) {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var padding: CGFloat = 8 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        var inset = UIEdgeInsets(
            top: labelFont.pointSize + padding,
            left: 0,
            bottom: labelFont.pointSize + padding,
            right: 0)
        
        return UIEdgeInsetsInsetRect(bounds, inset)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: titleLabel.bounds.height)
        errorLabel.frame = CGRect(x: 0, y: bounds.height - errorLabel.bounds.height, width: bounds.width, height: errorLabel.bounds.height)
        underline.frame = CGRect(x: 0, y: bounds.height - labelFont.pointSize - 4, width: bounds.width, height: borderWidth)
        
        if error?.isEmpty != nil {
            underline.backgroundColor = errorColor.CGColor
        } else if isFirstResponder() {
            underline.backgroundColor = highlightedColor.CGColor
        } else {
            underline.backgroundColor = borderColor.CGColor
        }
    }
    
    private func setup(){
        self.backgroundColor = UIColor.clearColor()
        self.borderStyle = UITextBorderStyle.None
        self.layer.cornerRadius = 0
        self.textColor = UIColor.whiteColor()
        
        titleLabel.font = labelFont
        titleLabel.textColor = labelColor
        titleLabel.sizeToFit()
        addSubview(titleLabel)
        
        errorLabel.font = labelFont
        errorLabel.textColor = errorColor
        errorLabel.sizeToFit()
        addSubview(errorLabel)
        
        layer.addSublayer(underline)
    }
}
