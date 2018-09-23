//
//  SettingCell.swift
//  YouTube
//
//  Created by liroy yarimi on 22.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting?{
        didSet{
            nameLabel.text = setting?.name.rawValue
            if let imageName = setting?.imageName{
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Setting"
//        label.textAlignment = .center
        return label
    }()
    
    let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithVisualFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
        addConstraintsWithVisualFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithVisualFormat(format: "V:|-10-[v0(30)]-10-|", views: iconImageView)
        
        
        //make the image center y ancor
//        addConstraint(NSLayoutConstraint(item: iconImageView , attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

    }
}
