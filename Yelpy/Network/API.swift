//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    

    
    static func getRestaurants(completion: @escaping ([[String:Any]]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "Z8LimjUzX2YExc7LpwpsxRIJlEZ8gYlBUMexuTFzdE3F6fvI4nnP55JI_NB4L2n364oBRszGCZEKaE9fHXRHIj1fwo-3wllKx5Mk1qwxeDft5SUVzm3IPdaGJeAcY3Yx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { data, response, error in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                
                // ––––– TODO: Get data from API and return it using completion
                print(data)
                
                //1.convert json response to a dictionary
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //2.grab the business data and convert it to an array of dictionaries
                //for each restaurant
                let restaurants = dataDictionary["businesses"] as! [[String: Any]]
                var names = [String]()
                for rawData in restaurants {
                    let name = rawData["name"] as! String
                    names.append(name)
                }
                //3. completion is an escaping method which allows the data to be used outside of the closure
                
                return completion(restaurants)
//                completion(names)
                
                }
            }
        
            task.resume()
        
        }
    }

    
