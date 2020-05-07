//
//  CustomTextField.swift
//  OnTheMap
//
//  Created by AlHassan Al-Mehthel on 13/09/1441 AH.
//  Copyright © 1441 AlHassan Al-Mehthel. All rights reserved.
//

import UIKit

// custom view class with textField to prevent code repitition in LognVC.
class CustomTextField : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2984803083)
        self.layer.cornerRadius = 30
        
        self.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
  
    lazy var textField : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Helvetica", size: 20)
        $0.textColor = .white
        $0.autocapitalizationType = .none
        $0.tintColor = .white
        return $0
    }(UITextField())
}


extension UITextField {
    // this function to color textField placeholder with any color we like
    func setupPlaceholder(text : String) {
        self.attributedPlaceholder = NSAttributedString(string: text,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    }
}
