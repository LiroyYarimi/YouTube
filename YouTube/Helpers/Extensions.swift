//
//  Extensions.swift
//  YouTube
//
//  Created by liroy yarimi on 17.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

//MARK: - Extension - easyer to change color
/***************************************************************/

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

//MARK: - Extension - easyer to add constraint
/***************************************************************/

extension UIView{
    func addConstraintsWithVisualFormat(format: String, views: UIView...){
        
        var viewsDictionary = [String: UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

//MARK: - Extension - easyer to change image
/***************************************************************/

//images cache is save the images and fix the delay
let imageCache = NSCache<AnyObject, AnyObject>()


extension UIImageView{
//class CustomImageView: UIImageView{//over the broblem that image loaded in the worng place (lecture 5 minute 10)

    //get and change the images from json
    func loadImageUsingUrlString( urlString: String){
        let url = URL(string: urlString)
        
        image = nil
        //if we already loaded this image, we can get it from the imageCache
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            //we must have been on main thread (mode) for chaging the image
            DispatchQueue.main.async(execute: { () -> Void in
//                self.image = UIImage(data: data!)
                
                //save this image in our omageCache
                let imageToCache = UIImage(data: data!)
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                self.image = imageToCache
            })
            }.resume()
    }   
}
