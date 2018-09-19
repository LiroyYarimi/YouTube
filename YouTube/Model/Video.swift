//
//  Video.swift
//  YouTube
//
//  Created by liroy yarimi on 18.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String? //the main image in video cell
    var title: String?
    var numberOfViews : NSNumber?
    var uploadData: NSData?
    
    var channel: Channel?
    
    
    
}

class Channel: NSObject {
    
    var name: String?
    var profileImageName : String?
    
}
