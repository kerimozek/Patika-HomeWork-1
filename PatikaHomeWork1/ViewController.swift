//
//  ViewController.swift
//  PatikaHomeWork1
//
//  Created by Mehmet Kerim ÖZEK on 7.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    //Defining Constants and Variables
    @IBOutlet weak var tableView: UITableView!
    let nameCellIdentifier = "nameCellIdentifier"
    let dataTransfer = "NewData"
    var newName: String?
    var newCity: String?
    var newNumber: String?
    var nameArray: [String] = []
    var cityArray: [String] = []
    var numberArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //CustomCell Registered to TableView and Referred Delegate and DataSource to Self
        tableView.register(.init(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: nameCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        //NotificationCenter used to take message from SecondViewController
        NotificationCenter.default.addObserver(self, selector: #selector(newInfo(notification:)), name: NSNotification.Name(rawValue: dataTransfer), object: nil)
        
    }
    
    
    @IBAction func addButtonClicked(_ sender: Any) {
        
        //Delegate Referred to Self and Pass to SecondViewController
        let goSecondVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        goSecondVC.infoDelegate = self
        goSecondVC.modalPresentationStyle = .fullScreen
        present(goSecondVC, animated: true, completion: nil)
        
    }
    
    @IBAction func editButtonClicked(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
    }
    
    //Taking Message From SecondViewController with NotificationCenter's Selector
    @objc func newInfo(notification: NSNotification) {
        
        newName = notification.userInfo?["name"]  as? String
        newCity = notification.userInfo?["city"] as? String
        nameArray.append(newName!)
        cityArray.append(newCity!)
        
        self.tableView.reloadData()
    }
    
}


//----------------EXTENSIONS----------------//

//Extension for TableViewDataSource
extension ViewController: UITableViewDataSource {
    
    //Setting Number of Section for TableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    //Setting Cell Title for TableView
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: nameCellIdentifier, for: indexPath) as! CustomCell
        cell.nameLabel.text = "Name: \(nameArray[indexPath.row])"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Deleting Rows From TableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.nameArray.remove(at: indexPath.row)
            self.cityArray.remove(at: indexPath.row)
            self.numberArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
    }
    
    //Moving Rows on TableView
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObjectName = nameArray[sourceIndexPath.item]
        let movedObjectCity = cityArray[sourceIndexPath.item]
        let movedObjectNumber = numberArray[sourceIndexPath.item]
        nameArray.remove(at: sourceIndexPath.item)
        cityArray.remove(at: sourceIndexPath.item)
        numberArray.remove(at: sourceIndexPath.item)
        nameArray.insert(movedObjectName, at: destinationIndexPath.item)
        cityArray.insert(movedObjectCity, at: destinationIndexPath.item)
        numberArray.insert(movedObjectNumber, at: destinationIndexPath.item)
    }
    
}

extension ViewController: UITableViewDelegate {
    
    //Going to Details Page From TableView Selected Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailsPage = storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController{
            detailsPage.name = "Name: \(nameArray[indexPath.row])"
            detailsPage.city = "City: \(cityArray[indexPath.row])"
            detailsPage.number = "Number: \(numberArray[indexPath.row])"
            self.navigationController?.pushViewController(detailsPage, animated: true)
            
        }
    }
    
}

//Extension For Delegate to Take Info From SecondViewController
extension ViewController: GetInfoDelegate {
    
    func didSaveClicked(enterNumber: String) {
        newNumber = enterNumber
        numberArray.append(newNumber!)
        self.tableView.reloadData()
    }
}

