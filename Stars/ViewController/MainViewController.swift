//
//  ViewController.swift
//  Stars
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  //MARK:- IBOutlets-
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var distanceTextField: UITextField!
  @IBOutlet weak var printStarts: UIButton!
  @IBOutlet weak var create: UIButton!
  
  //MARK:- Properties
  
  private let starController = StarController()
  
  //MARK:- View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    
  }
  
  @IBAction func printTapped(_ sender: UIButton) { print("Printed") }
  
  //MARK:- Action-
  @IBAction func createTapped(_ sender: UIButton) {
    guard let name = nameTextField.text,
          let distanceString = distanceTextField.text,
          let distance = Double(distanceString) else { return }
    
    starController.createStar(with: name, distance: distance)
    //There is new information , make new cells !
    tableView.reloadData()
  }
  
  
}
extension MainViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return starController.stars.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "StarCell", for: indexPath)
    let star = starController.stars[indexPath.row]
    cell.textLabel?.text = star.name
    cell.detailTextLabel?.text = "\(star.distance)"
    return cell
  }
}
