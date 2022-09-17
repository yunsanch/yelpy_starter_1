//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //how many cells there will be
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create Restaruant cell
        let cell = tableview.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = restaurantsArray[indexPath.row]
        
        //Set Label to restaurant name for each cell
        cell.label.text = restaurant["name"] as? String ?? ""
        
        //set image of restaurant
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageUrl = URL(string: imageUrlString)
            cell.restaurantimageview.af.setImage(withURL: imageUrl!)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = restaurantsArray[indexPath.row]
        let detailsVC = DetailViewController()
//        navigationController?.pushViewController(detailsVC, animated: true)
        present(detailsVC,animated: true,completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toDetailsVC"{
//            let detailVc = segue.destination as! DetailViewController
//        }
//    }
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    
    @IBOutlet weak var tableview: UITableView!
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [[String:Any]] = []
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        getAPIData()
        tableview.rowHeight = 150
        navigationItem.title = "Restaurants"

    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData() {
        API.getRestaurants() {
            (restaurants) in guard let restaurants = restaurants else {
                return
            }
            print(restaurants)
            self.restaurantsArray = restaurants
            self.tableview.reloadData() //reload data!
        }
    }

}

// ––––– TODO: Create tableView Extension and TableView Functionality


