//
//  CustomCell.swift
//  PatikaHomeWork1
//
//  Created by Mehmet Kerim ÖZEK on 8.09.2022.
//

import UIKit

class CustomCell: UITableViewCell {

    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    // 
        
        nameLabel.numberOfLines = 0

        
    }

    
    
}
