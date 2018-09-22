//
//  HomeController.swift
//  YouTube
//
//  Created by liroy yarimi on 17.9.2018.
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


class HomeController:  UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var videos : [Video]?
//        didSet{
//            collectionView?.reloadData()
//        }
//    }
//    var videos: [Video] = {
//
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeIsTheBestChannel"
//        kanyeChannel.profileImageName = "kanye_profile"
//
//        var blackSpaceVideo = Video()
//        blackSpaceVideo.title = "Taylor Swift - Blank Space"
//        blackSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
//        blackSpaceVideo.channel = kanyeChannel
//        blackSpaceVideo.numberOfViews = 42543534533432423
//
//
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
//        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numberOfViews = 4423423566632
//
//        return [blackSpaceVideo,badBloodVideo]
//
//    }()
    
    
    
    

    //completionHandler: @escaping (HomeController) -> ()
    func fetchVideos(){
        
        let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        
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
            self.jsonRequest(data: data)

            //we must have been on main thread (mode) for reload data
            DispatchQueue.main.async(execute: { () -> Void in
                self.collectionView?.reloadData()
            })
            
        }.resume()
    }
    func jsonRequest(data:Data){
        do{
            let jsonVideos = try JSONDecoder().decode([VideoStruct].self, from: data)
            
            self.videos = [Video]()
            for jsonVideo in jsonVideos {
                
                let channel = Channel(name: jsonVideo.channel?.name, profileImageName: jsonVideo.channel?.profile_image_name)
                let video = Video(thumbnailImageName: jsonVideo.thumbnail_image_name, title: jsonVideo.title, numberOfViews: jsonVideo.number_of_views, uploadData: nil, channel: channel)
                self.videos?.append(video)
            }
            
        } catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false //darker color
        
        //make a better looking title
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))//32 is for spacing from the left side
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)//push the collectionView 50 pixel down for menuBar
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)//push down the scroller view (the vertical line in the right side) because the mune bar
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    //search button and three points button
    func setupNavBarButtons(){
        
        //search bar button
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)//make the search bar white
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        //more bar button (3 points)
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]//rightBarButtonItems with 's' in the end!!

    }
    
    //this func call when user press on more button (3 points)
    @objc func handleMore(){
        print("more button is pressed")
    }
    
    //this func call when user press on search button
    @objc func handleSearch(){
        print("search button is pressed")
    }
    
    //create menu bar
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithVisualFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithVisualFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    //sizeForItemAt- cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height = (view.frame.width - 16 - 16) * 9 / 16 // we want shape of 16x9
        height += 16 + 88 // for the title and profile image
        
        return CGSize(width: view.frame.width, height: height )
    }
    
    
    //cellForItemAt - create cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    //numberOfItemsInSection - number of cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return videos?.count ?? 0 //if videos nil return 0 else return videos.count
    }
    
    //minimumLineSpacingForSectionAt - space between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 //no space
    }



}

