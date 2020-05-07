//
//  Activity.swift
//  OnTheMap
//
//  Created by AlHassan Al-Mehthel on 13/09/1441 AH.
//  Copyright © 1441 AlHassan Al-Mehthel. All rights reserved.
//

import UIKit

//here implement the Activity Indicator & we can call it to anywhere.
struct ActivityIndicator {
    private static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    // proparity of ActivityIndicator
    static func startActivity(view: UIView){
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    //To stop ActivityIndicator..
    static func stopActivity(){
        activityIndicator.stopAnimating()
    }
}
