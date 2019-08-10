//
//  StandartWayViewController.swift
//  Wether
//
//  Created by  Виктор Борисович on 10.08.2019.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class BlackStarViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let categoryCellIdentifier = "CategoryCell"
    var categories: [Category] = []
    var imageCache: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoriesLoader().loadCategoriesCallBack(callBack: {categories in
            self.categories = categories
            self.tableView.reloadData()
        })
        // сокращенный вариант
        //CategoriesLoader().loadCategoriesCallBack{categories in }
//        let loader = CategoriesLoader()
//        loader.delegate = self
//        loader.loadCategoriesTask()
    }
}

extension BlackStarViewController: CategoriesLoaderDelegate {
    func loaded(categories: [Category]) {
        self.categories = categories
        tableView.reloadData()
    }
}

extension BlackStarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier) as! CategoryTableViewCell
        
        let currentCategory = categories[indexPath.row]
        cell.titleLabel.text = currentCategory.name
        cell.countLabel.text = "\(currentCategory.sortOrder)"
        
        if currentCategory.imageUrl.count > 0 {
            let stringUrl = "https://blackstarshop.ru/\(currentCategory.imageUrl)"

//            print("stringUrl \(stringUrl)")
//            cell.imageView?.af_setImage(withURL: URL(fileURLWithPath: stringUrl), completion: { _ in
//                print("image loaded!")
//            })
            
            Alamofire.request(stringUrl).responseImage { response in
//                debugPrint(response)
                
//                print(response.request)
//                print(response.response)
//                debugPrint(response.result)
                
                if let image = response.result.value {
//                    print("image downloaded: \(image)")
                    cell.imageView?.image = image
                }
            }
            
//            Alamofire.request(imageUrl!, method: .get).response { response in
//                guard let image = UIImage(data:response.data!) else {
//                    // Handle error
//                    return
//                }
//                let imageData = UIImageJPEGRepresentation(image,1.0)
//                cell.myImage.image = UIImage(data : imageData!)
//            }
        }
        
        return cell
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        //https://blackstarshop.ru/image/catalog/im2017/4.png
//
//        if let imageUrl =
//    }
}

//extension UIImageView {
//    func downloadImageFrom(withLink link:String, contentMode: UIView.ContentMode) {
//        URLSession.sharedSession.dataTaskWithURL( NSURL(string:link)!, completionHandler: {
//            (data, response, error) -> Void in
//            dispatch_async(dispatch_get_main_queue()) {
//                self.contentMode =  contentMode
//                if let data = data { self.image = UIImage(data: data) }
//            }
//        }).resume()
//    }
//}
