//
//  Category.swift
//  Wether
//
//  Created by  Виктор Борисович on 10.08.2019.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class Category {
    let name: String
    let sortOrder: Int
    let imageUrl: String
    
    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
            let sortOrder = data["sortOrder"] as? String,
            let imageUrl = data["image"] as? String else {
                return nil
        }
        
        self.name = name
        self.sortOrder = Int(sortOrder) ?? 0
        self.imageUrl = imageUrl
    }
}
