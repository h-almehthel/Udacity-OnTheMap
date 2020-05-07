//
//  Requests.swift
//  OnTheMap
//
//  Created by AlHassan Al-Mehthel on 08/09/1441 AH.
//  Copyright © 1441 AlHassan Al-Mehthel. All rights reserved.
//

import UIKit

class API: NSObject {
    
    static var share = API()
    
    // login user with udacity email and password
    func userAuth(email : String, password : String, completion : @escaping (_ userInfo : UserAccountAndSessionData?, _ error : Error?)->()) {
        var request = URLRequest(url: URL(string: Udacity.base.rawValue + "/session")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            let statusCode = (response as? HTTPURLResponse)?.statusCode

            if statusCode! >= 200 && statusCode! <= 299 {
                let range = (5..<data!.count)
                let newData = data?.subdata(in: range) /* subset response data! */
                do {
                    if let data = newData {
                        let results = try JSONDecoder().decode(UserAccountAndSessionData.self, from: data)
                        completion(results, nil)
                    }
                }
                catch {
                    print("error ", error)
                }
                
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    
    // get all students data
    func getStudentsData(completion : @escaping (_ studentsData : StudentsResults?, _ error : Error?)->() ) {
        var request = URLRequest(url: URL(string: Udacity.base.rawValue + "/StudentLocation")!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                // success
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                if statusCode == 200 {
                    do {
                        if let data = data {
                            let results = try JSONDecoder().decode(StudentsResults.self, from: data)
                            completion(results, nil)
                        }
                    }
                    catch {
                        print("error ", error)
                    }
                } else {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
        task.resume()
        
    }
    
    // get student after updating thire locations
    func getUpdatedStudentsData(completion : @escaping (_ studentsData : StudentsResults?, _ error : Error?)->() ) {
        var request = URLRequest(url: URL(string: Udacity.base.rawValue + "/StudentLocation?limit=100&order=-updatedAt")!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                if statusCode == 200 {
                    do {
                        if let data = data {
                            let results = try JSONDecoder().decode(StudentsResults.self, from: data)
                            completion(results, nil)
                        }
                    }
                    catch {
                        print("error ", error)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    // posing user location
    func postStudentLocation(uniqueKey : String, mapString : String, mediaURL : String, latitude : Double, longitude : Double, completion: @escaping (_ success : Bool)->() ) {
        var request = URLRequest(url: URL(string: Udacity.base.rawValue + "/StudentLocation")!)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \" AlHassan \", \"lastName\": \" Al-Mehthel\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil { // Handle error…
                completion(false)
                return
            }
            print(String(data: data!, encoding: .utf8)!)
            completion(true)
        }
        task.resume()
    }
    
    // deleting session from server
    func deleteSession(completion : @escaping ()->() ) {
        var request = URLRequest(url: URL(string: Udacity.base.rawValue + "/session")!)
        request.httpMethod = HTTPMethod.delete.rawValue
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
            completion()
        }
        task.resume()
    }
    
}
