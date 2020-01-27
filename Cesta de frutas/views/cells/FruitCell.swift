//
//  FruitCell.swift
//  Cesta de frutas
//
//  Created by Joel Júnior on 27/01/20.
//  Copyright © 2020 jnr. All rights reserved.
//

import UIKit

class FruitCell: UITableViewCell {
    
    var fruit = Fruit()
    
    var labelName: UILabel = {
       let label = UILabel()
        label.text = "fruta"
        label.textColor = UIColor(rgb: Colors.blue)
        label.font = label.font.withSize(20)
        return label
    }()
    
    func setCell(index: Int, fruit: Fruit) {
        labelName.text = "\(index) - \(fruit.name)"
        
        self.fruit = fruit
        
        addSubview(labelName)
        
        addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: labelName)
        addConstraintWithFormat(format: "V:|-16-[v0]-16-|", views: labelName)
        
    }
}
