//
//  DayWeatherTableViewCell.swift
//  Wether
//
//  Created by  Виктор Борисович on 10.08.2019.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class DayWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var someLabel: UILabel!
    @IBOutlet weak var dataContainer: UIStackView!
    
    func addRow(leftColumnText l: String, rightColumnText r: String) {
        let leftLabel = UILabel()
        leftLabel.text = l
        
        let rightLabel = UILabel()
        rightLabel.text = r
        
        let labelStack = UIStackView()
        labelStack.axis = .horizontal
        labelStack.distribution = .fillEqually
        labelStack.alignment = .center
        labelStack.spacing = 0
        
        labelStack.addArrangedSubview(leftLabel)
        labelStack.addArrangedSubview(rightLabel)
        
        dataContainer.addArrangedSubview(labelStack)
    }
    
    func clearRows() {
        for element in dataContainer.arrangedSubviews {
            dataContainer.removeArrangedSubview(element)
            element.removeFromSuperview()
        }
    }
}
