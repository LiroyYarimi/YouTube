//
//  VideoLauncher.swift
//  YouTube
//
//  Created by liroy yarimi on 25.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {
    
    //MARK: - Properties Declaration
    /***************************************************************/
    
    var view :UIView?
    
    var videoPlayerView : VideoPlayerView?
    
    //MARK: - showVideoPlayer - Main Function
    /***************************************************************/
  
    func showVideoPlayer(){
        
        if let keyWindow = UIApplication.shared.keyWindow{
            
            view = UIView(frame: keyWindow.frame)
            view?.backgroundColor = .white
            
            //little square on the right bottom corner
            view?.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            //16x9 is the aspect of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            self.videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            view?.addSubview(self.videoPlayerView!)
            keyWindow.addSubview(view!)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.view?.frame = keyWindow.frame//get the view full size
//                print("width: \(self.view!.frame.width)   height: \(self.view!.frame.height)")
                
            }) { (completedAnumation) in
                
                UIApplication.shared.setStatusBarHidden(true, with: .fade)//hide the status bar
            }
        }

    }

    

    
}
