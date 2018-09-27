//
//  HomeController.swift
//  YouTube
//
//  Created by liroy yarimi on 17.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class HomeController:  UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    //MARK: - Properties Declaration
    /***************************************************************/
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    
    let navigationBarTitle = ["Home","Trending","Subscriptions","Account"]
    
    //we definition this way because we want to do this line of code "launcher.homeController = self" one time only and not every time user press the more button.
    //we need to use lazy var because at the start settingsLauncher is nil so we can't do this line: launcher.homeController = self
    lazy var settingsLauncher : SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()

    //MARK: - viewDidLoad - Main Function
    /***************************************************************/

    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationController?.navigationBar.isTranslucent = false //darker color
        
        //make a better looking title
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))//32 is for spacing from the left side
        titleLabel.text = "  Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    //MARK: - Functions
    /***************************************************************/
    
    func setupCollectionView(){
        
        //get the layout parameter from appDelegate
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal //make the scrolling horizontal
            flowLayout.minimumLineSpacing = 0 //zero spacing between cells
        }
            
            
        collectionView?.backgroundColor = .white
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)

        
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)//push the collectionView 50 pixel down for menuBar
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)//push down the scroller view (the vertical line in the right side) because the mune bar
        
        //make that will be only one view cell on our view
        collectionView?.isPagingEnabled = true
    }
    
    
    
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
        //show setting menu
        
        settingsLauncher.showSettings()
    }
    
    //show controller for setting
    func showControllerForSetting(setting: Setting){
        
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = .white //background color
        dummySettingsViewController.navigationItem.title = setting.name.rawValue //change the title
        navigationController?.navigationBar.tintColor = .white// chnage the "back" color
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]// chnage the title color
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    //this func call when user press on search button
    @objc func handleSearch(){
        print("search button is pressed")
    }
    
    //scroll the view according to menu bar button
    func scrollToMenuIndex(menuIndex: Int){
        
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        
        setTitleForIndex(index: menuIndex)
    }
    
    //set the title of the navigation bar
    private func setTitleForIndex(index: Int){
        
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = "  \(navigationBarTitle[index])"
        }
    }
    
    //create menu bar
    private func setupMenuBar(){
        
        navigationController?.hidesBarsOnSwipe = true //it's hide the navigation bar when the user is swiping
        
        //this redView is for to make the process of the hide navigation bar more smooth
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithVisualFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithVisualFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithVisualFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithVisualFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true//without this line, the menu bar will half cut
    }
    
    //----collection view
    
    //move the rectangle white menu bar when user scrolling
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x)
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    
    //this func call when the scroll view is ended
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let targetIndex = Int(targetContentOffset.move().x / view.frame.width)
        
        let indexPath = IndexPath(item: targetIndex, section: 0)
        menuBar.collectionView.selectItem(at: indexPath , animated: true, scrollPosition: [])
        
        setTitleForIndex(index: targetIndex)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.item == 1{
            identifier = trendingCellId
        }else if indexPath.item == 2{
            identifier = subscriptionCellId
        }else{
            identifier = cellId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)//50 come from the size of the menu bar
    }
}

