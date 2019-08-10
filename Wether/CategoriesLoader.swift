//
//  CategoriesLoader.swift
//  Wether
//
//  Created by  Виктор Борисович on 10.08.2019.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

protocol CategoriesLoaderDelegate {
    func loaded(categories: [Category])
}

class CategoriesLoader {

    var delegate: CategoriesLoaderDelegate?

    func loadCategoriesTask() {
        let url = URL(string: "https://blackstarshop.ru/index.php?route=api/v1/categories")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { responseData, response, error in
            if let data = responseData,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDictionary = json as? NSDictionary {
                    var categories: [Category] = []
                
                    for (_, jsonCategory) in jsonDictionary where jsonCategory is NSDictionary {
                        if let category = Category(data: jsonCategory as! NSDictionary) {
                            categories.append(category)
                        }
                    }
                
                    print("categories count: \(categories.count)")
                
                    DispatchQueue.main.async {
                        self.delegate?.loaded(categories: categories)
                    }
                }
        }
        
        task.resume()
    }
    
    func loadCategoriesCallBack(callBack: @escaping ([Category]) -> Void) {
        let url = URL(string: "https://blackstarshop.ru/index.php?route=api/v1/categories")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { responseData, response, error in
            if let data = responseData,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDictionary = json as? NSDictionary {
                var categories: [Category] = []
                
                for (_, jsonCategory) in jsonDictionary where jsonCategory is NSDictionary {
                    if let category = Category(data: jsonCategory as! NSDictionary) {
                        categories.append(category)
                    }
                }
                
                print("categories count: \(categories.count)")
                
                DispatchQueue.main.async {
                    callBack(categories)
                }
            }
        }
        
        task.resume()
    }
}
