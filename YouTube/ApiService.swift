//
//  ApiService.swift
//  YouTube
//
//  Created by liroy yarimi on 23.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

//this two struct are for read the json
struct VideoStruct :Decodable{
    let title: String?
    let number_of_views: Int?
    let thumbnail_image_name: String?
    let channel : ChannelStruct?
    let duration: Int?
}
struct ChannelStruct :Decodable{
    let name: String?
    let profile_image_name: String?
}

class ApiService {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()){ //create a completion block to send the videos array between classes
        
        fetchFeedForUrlString(urlString: "\(baseUrl)home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()){ //create a completion block to send the videos array between classes

        fetchFeedForUrlString(urlString: "\(baseUrl)trending.json", completion: completion)

    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()){ //create a completion block to send the videos array between classes
        
        fetchFeedForUrlString(urlString: "\(baseUrl)subscriptions.json", completion: completion)

    }
    
    //deal with the json data
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()){
        
        guard let url = URL(string: urlString) else //noted is URL and not NSURL. urlString could be nil so we use guard
        {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil{
                print(error!)
                return
            }
            guard let data = data else {
                print("data is nil")
                return
            }
            //            self.jsonRequest(data: data)
            
            do{
                let jsonVideos = try JSONDecoder().decode([VideoStruct].self, from: data)
                
                var videos = [Video]()
                for jsonVideo in jsonVideos {
                    
                    let channel = Channel(name: jsonVideo.channel?.name, profileImageName: jsonVideo.channel?.profile_image_name)
                    let video = Video(thumbnailImageName: jsonVideo.thumbnail_image_name, title: jsonVideo.title, numberOfViews: jsonVideo.number_of_views, uploadData: nil, channel: channel)
                    videos.append(video)
                }
                
                //we must have been on main thread (mode) for sending data
                DispatchQueue.main.async(execute: { () -> Void in
                    completion(videos)//send the videos array the HomeController
                })
                
            } catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
            }.resume()
    }
}
