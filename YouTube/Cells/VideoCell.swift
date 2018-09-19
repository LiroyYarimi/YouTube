//
//  VideoCell.swift
//  YouTube
//
//  Created by liroy yarimi on 17.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    var video : Video?{
        didSet{ //this call when video is set (from HomeController)
            titleLabel.text = video?.title
            if let thumbnailImageName = video?.thumbnailImageName{
                thumbnailImageView.image = UIImage(named: thumbnailImageName)
            }
            if let profileImageName = video?.channel?.profileImageName{
                userProfileImageView.image = UIImage(named: profileImageName)
            }
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews{
                
                let numberFormatter = NumberFormatter()//make ',' between every 3 digits 
                numberFormatter.numberStyle = .decimal
                
                subtitleTextView.text = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 2 years ago"
            }
            
            //measure title text height (colculate height)
            if let title = video?.title {
                let size = CGSize(width: frame.width-16-44-8-16, height: 1000)//-16-44-8-16 means, 16 space from left side, 44 profile image, 8 space between profile image to label, and another 16 space from right side
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20{
                    titleLabelHeightConstraint?.constant = 44
                }else{
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            
        }
    }
    //colculate height for the label
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    let thumbnailImageView : UIImageView = {//main image
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill //keep the image not stretching
        imageView.clipsToBounds = true //keep the image in the cell and not overing.
        return imageView
    }()
    
    //line between cell
    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let userProfileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22 //we want round image so if the image size is 44x44 so lets round it by half(22).
        imageView.layer.masksToBounds = true //for the round corners
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)//the text have default 4 pixel to the right so we delete it
        textView.textColor = UIColor.lightGray
        return textView
    }()
    

    
    override func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithVisualFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView,separatorView)//36 is the space between profile image to separator line
        addConstraintsWithVisualFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsWithVisualFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: separatorView)
        
        constraintTitleLabel()
        constraintSubtitleTextView()
        


    }
    
    // constraint for titleLabel - we do that way because we want the cell match to the text size
    func constraintTitleLabel(){
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)//didSet is override this colculate (override the constant property)
        addConstraint(titleLabelHeightConstraint!)//44 is for two line
    }
    
//         constraint for subtitleTextView - we do that way because we want the cell match to the text size
    func constraintSubtitleTextView(){
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}




