//
//  Video.swift
//  YouTube
//
//  Created by liroy yarimi on 18.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class Video{ //: NSObject
    
    var thumbnailImageName: String? //the main image in video cell
    var title: String?
    var numberOfViews : Int?//NSNumber?
    var uploadData: NSData?
    var channel: Channel?
    
//    override init() {
//    }
    
    init(thumbnailImageName: String?, title: String?, numberOfViews: Int?, uploadData: NSData?, channel: Channel?) {
        self.thumbnailImageName = thumbnailImageName
        self.channel = channel
        self.title = title
        self.numberOfViews = numberOfViews
        self.uploadData = uploadData
    }
    
}

class Channel{ //: NSObject
    
    var name: String?
    var profileImageName : String?
    
//    override init() {
//    }
    
    init(name: String?, profileImageName: String?){
        self.name = name
        self.profileImageName = profileImageName
    }
    
}