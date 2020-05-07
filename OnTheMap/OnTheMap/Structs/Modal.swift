//
//  Modal.swift
//  OnTheMap
//
//  Created by AlHassan Al-Mehthel on 08/09/1441 AH.
//  Copyright © 1441 AlHassan Al-Mehthel. All rights reserved.
//

import UIKit

//MARK: user data
struct UserAccountAndSessionData : Codable {
    let account : UserAccountData
    let session : UserSessionData
}

struct UserSessionData : Codable {
    let id : String?
    let expiration : String?
}

struct UserAccountData : Codable {
    let registered : Bool?
    let key : String?
}



//MARK: all students data
struct StudentsResults : Codable {
    let results : [StudentData]
}

struct StudentData : Codable {
    let firstName : String?
    let lastName : String?
    let longitude : Double?
    let latitude : Double?
    let mapString : String?
    let mediaURL : String?
    let uniqueKey : String?
    let objectId : String?
    let createdAt : String?
    let updatedAt : String?
}


//MARK: user new location
struct NewUserLocation {
    let latitude : Double?
    let longitude : Double?
    let mspString : String?
}
