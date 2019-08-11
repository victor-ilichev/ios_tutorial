//
//  CoreDataToDoViewController.swift
//  Wether
//
//  Created by  Виктор Борисович on 11.08.2019.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import CoreData

class CoreDataToDoViewController: UIViewController {

    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    var todoList: [NSManagedObject] = []
    
    private var displayToDoLimit = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoEntity")
        let sort = NSSortDescriptor(key: #keyPath(ToDoEntity.dateAdd), ascending: false)
        request.sortDescriptors = [sort]
        request.fetchLimit = displayToDoLimit
        let context = appDelegate.persistentContainer.viewContext
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as! String
                let label = createLabel(text: title)
                
                //print("td: \(td.dateAdd)")
                stackView.addArrangedSubview(label)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    @IBAction func onToDoCreate(_ sender: UIButton) {
        if let textValue = textView.text, textValue.count > 0 {
            save(name: textValue)

        }
    }
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDoEntity")
//
//        do {
//            todoList = try managedContext.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }

    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ToDoEntity", in: managedContext)!
        let toDoEntity = NSManagedObject(entity: entity, insertInto: managedContext)
        toDoEntity.setValue(name, forKeyPath: "title")
        toDoEntity.setValue(Date(), forKeyPath: "dateAdd")
        
        do {
            try managedContext.save()
            todoList.append(toDoEntity)
            
            textView.text = ""
            
            if stackView.arrangedSubviews.count >= displayToDoLimit {
                let lastRow = self.stackView.arrangedSubviews.last!
                stackView.removeArrangedSubview(lastRow)
                
                stackView.setNeedsLayout()
                stackView.layoutIfNeeded()
                
                lastRow.removeFromSuperview()
            }
            
            stackView.insertArrangedSubview(self.createLabel(text: name), at: 0)
            stackView.setNeedsLayout()
            
            loadViewIfNeeded()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
