//
//  ViewController.swift
//  PatikaHomeWork1
//
//  Created by Mehmet Kerim ÖZEK on 7.09.2022.
//

import UIKit



class ViewController: UIViewController {

    
   
    @IBOutlet weak var tableView: UITableView!
    
    
    var newName: String?
    var newCity: String?
    var nameArray: [String] = []
    var cityArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(newInfo(notification:)), name: NSNotification.Name(rawValue: "NewData"), object: nil)
        
    }
    
    
    @IBAction func addButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSecondViewController", sender: nil)
    }
    
    
    
    @objc func newInfo(notification: NSNotification) {
        
        newName = notification.userInfo?["name"]  as? String
        newCity = notification.userInfo?["city"] as? String
        
        nameArray.append(newName!)
        cityArray.append(newCity!)
        
        self.tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
        
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let detailsPage = storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController{
            detailsPage.name = nameArray[indexPath.row]
            detailsPage.city = cityArray[indexPath.row]
            self.navigationController?.pushViewController(detailsPage, animated: true)
            
        }
    }
    
}
