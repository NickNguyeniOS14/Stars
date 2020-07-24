//
//  StarController.swift
//  Stars
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation
// Model Controller - The object that controls the app's interaction with the model object. Model controllers are almost always classes.

//DRY- Don't Repeat Yourself

class StarController {
  //CRUD - The basic interactions that your app will (likely) have with the model object
  
  //Create
  
  //"ViewDidLoad" of the StarsController
  init() {
    loadFromPersistentStore()
  }
  
  //Read -
  var stars = [Star]()
  //We can initialize a new star and return it to the caller , but we can also add it to the array of stars at the same time.
  func createStar(with name: String,distance:Double) {
    let star = Star(name: name, distance: distance)
    stars.append(star)
    saveToPersistentStore()
    
  }
  // Persistence
  //Update
  //Delete
  var persistentFileURL: URL? {
    
    let fileManager = FileManager.default
    // Find the document directory of the app
    guard  let documentsDir =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
    
    //~MyApp/Documents/stars.plist
    let starsURL = documentsDir.appendingPathComponent("stars.plist")
    return starsURL

  }
  
  
  func saveToPersistentStore() {
    guard let fileURL = persistentFileURL else { return }
    
    do {
      let encoder = PropertyListEncoder()
      //I want to turn my array of stars into a property list.
      let starsData = try encoder.encode(stars)
      
      try starsData.write(to: fileURL)
    } catch let err {
      print("Error encoding stars array: \(err)")
    }
  }
  
  func loadFromPersistentStore() {
    guard let fileURL = persistentFileURL else { return }
    do {
      let starsData = try Data(contentsOf: fileURL)
      let decoder = PropertyListDecoder()
      let starsArray = try decoder.decode([Star].self, from: starsData)
      stars = starsArray
    } catch let err {
      print("Error is \(err)")
    }
  }
}
