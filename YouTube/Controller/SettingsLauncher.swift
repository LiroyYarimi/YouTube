//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by liroy yarimi on 22.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String){
        self.name = name
        self.imageName = imageName
    }
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let blackView = UIView() //the dark view show when user pressed on the more button
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    enum settingOption : String {
        case setting = "Settings"
        case terms = "Terms & privacy policy"
        case feedback = "Send Feedback"
        case help = "Help"
        case account = "Switch Account"
        case cancel = "Cancel"
    }
    
    let settings: [Setting] = {
        return [Setting(name: settingOption.setting.rawValue, imageName: "settings"), Setting(name: settingOption.terms.rawValue, imageName: "privacy"), Setting(name: settingOption.feedback.rawValue, imageName: "feedback"), Setting(name: settingOption.help.rawValue, imageName: "help"), Setting(name: settingOption.account.rawValue, imageName: "switch_account"), Setting(name: settingOption.cancel.rawValue, imageName: "cancel")]
    }()
    
    var homeController: HomeController?
    
    //this func call when user press on more button (3 points)
    func showSettings(){
        //show menu
        
        //black backgroun view
        if let window = UIApplication.shared.keyWindow{
            //window is the full screen (view is under the menu bar)
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)//dark color
            
            //when user tap on the black view, call function handleBlackViewDismiss
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height : CGFloat = CGFloat(settings.count) * cellHeight
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
    @objc func handleDismiss(setting : Setting){
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow{
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //this animate is exactly like handleBlackViewDismiss()
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow{
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed : Bool) in
            //what happen after animate is finish
            
            let name = setting.name
            
            if name == settingOption.setting.rawValue || name == settingOption.terms.rawValue || name == settingOption.feedback.rawValue || name == settingOption.account.rawValue || name == settingOption.help.rawValue{
                self.homeController?.showControllerForSetting(setting: setting)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
//        let setting = settings[indexPath.item]
        cell.setting = settings[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //this function call when user select one of the settings button
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = self.settings[indexPath.item]

        handleDismiss(setting: setting)
        
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            //this animate is exactly like handleBlackViewDismiss()
//            self.blackView.alpha = 0
//
//            if let window = UIApplication.shared.keyWindow{
//                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
//            }
//        }) { (completed : Bool) in
//            //what happen after animate is finish
//
//            let setting = self.settings[indexPath.item]
//            if setting.name != "Cancel"{
//                self.homeController?.showControllerForSetting(setting: setting)
//            }
//        }
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}
