//
//  MenuCell.swift
//  YouTube
//
//  Created by liroy yarimi on 24.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class MenuCell : BaseCell{
    
    //MARK: - Properties Declaration
    /***************************************************************/
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    
    //this call when user press on the button
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    //this call when user select the button
    override var isSelected : Bool{
        didSet{
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    //MARK: - setupViews - Main function that call from init (BaseCell)
    /***************************************************************/
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addConstraintsWithVisualFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithVisualFormat(format: "V:[v0(28)]", views: imageView)
        
        //image should be in the center
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        
    }
}
