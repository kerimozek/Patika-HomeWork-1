//
//  SecondViewController.swift
//  PatikaHomeWork1
//
//  Created by Mehmet Kerim ÖZEK on 7.09.2022.
//

import UIKit

//Creating A Delegate Protocol
protocol GetInfoDelegate: AnyObject {
    func didSaveClicked(enterNumber: String)
}

class SecondViewController: UIViewController {
    
    //Defining Constants and Variables
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var numberField: UITextField!
    weak var infoDelegate: GetInfoDelegate?
    var name = ""
    var city = ""
    var number = ""
    let dataTransfer = "NewData"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = saveButton.frame.size.height/2
        
        nameField.text = name
        cityField.text = city
        numberField.text = number
        
        //Prohibition of Editing on TextFields
        if name != "" {
            saveButton.isHidden = true
            nameField.isUserInteractionEnabled = false
            cityField.isUserInteractionEnabled = false
            numberField.isUserInteractionEnabled = false
        }
        
        //Hiding Keyboard When Tap Somewhere on Screen
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        name = nameField.text!
        city = cityField.text!
        number = numberField.text!
        
        //Sending Info With Delegate
        self.infoDelegate!.didSaveClicked(enterNumber: number)
        
        //Sending Message and Info With Notification Center
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: dataTransfer), object: nil, userInfo: ["name": name, "city": city])
        
        dismiss(animated: true)
        
    }
    
}
