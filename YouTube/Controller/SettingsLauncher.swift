//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by liroy yarimi on 22.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    let blackView = UIView() //the dark view show when user pressed on the more button
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    //this func call when user press on more button (3 points)
    @objc func showSettings(){
        //show menu
        
        //black backgroun view
        if let window = UIApplication.shared.keyWindow{
            //window is the full screen (view is under the menu bar)
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)//dark color
            
            //when user tap on the black view, call function handleBlackViewDismiss
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBlackViewDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height : CGFloat = 200
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height , width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            //create a different animate
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y , width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
        
    }
    
    //dismiss the black view
    @objc func handleBlackViewDismiss(){
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow{
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }
    }
    
    override init() {
        super.init()
        
    }
}
