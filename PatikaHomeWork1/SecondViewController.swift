//
//  SecondViewController.swift
//  PatikaHomeWork1
//
//  Created by Mehmet Kerim ÖZEK on 7.09.2022.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var name = ""
    var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.text = name
        cityField.text = city
        
        if name != "" {
            saveButton.isHidden = true
            nameField.isUserInteractionEnabled = false
            cityField.isUserInteractionEnabled = false
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        name = nameField.text!
        city = cityField.text!
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewData"), object: nil, userInfo: ["name": name, "city": city])
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
