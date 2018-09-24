//
//  SubscriptionCell.swift
//  YouTube
//
//  Created by liroy yarimi on 24.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
