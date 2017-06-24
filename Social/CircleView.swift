//
//  CircleView.swift
//  Social
//
//  Created by Jacob Shoemaker on 6/23/17.
//  Copyright © 2017 Jacob Shoemaker. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

//    override func awakeFromNib() {
//        
//        super.awakeFromNib()
//        
//        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
//        layer.shadowOpacity = 0.8
//        layer.shadowRadius = 5.0
//        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }

}
