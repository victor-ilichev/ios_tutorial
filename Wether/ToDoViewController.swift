//
//  ToDoViewController.swift
//  Wether
//
//  Created by  Виктор Борисович on 11.08.2019.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

import RealmSwift

class ToDo: Object {
    @objc dynamic var title = ""
    @objc dynamic var dateAdd = Date()
}

class ToDoViewController: UIViewController {

    @IBOutlet weak var textFieldView: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    private let realm = try! Realm()
    private var displayToDoLimit = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let todos = try! Realm().objects(ToDo.self).sorted(byKeyPath: "dateAdd", ascending: false)
        
        if todos.count > 0 {
            let limit = todos.count >= displayToDoLimit ? displayToDoLimit : todos.count
            
            for i in 0..<limit {
                let td = todos[i]
                let label = createLabel(text: td.title)
                
                print("td: \(td.dateAdd)")
                stackView.addArrangedSubview(label)
            }
        }
    }
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }
    
    @IBAction func onSave(_ sender: UIButton) {
        if let textValue = textFieldView.text, textValue.count > 0 {
            let newToDo = ToDo()
            newToDo.title = textValue
            newToDo.dateAdd = Date()
            
            try! realm.write {
                realm.add(newToDo)
            }
            
            textFieldView.text = ""
            
            if stackView.arrangedSubviews.count >= displayToDoLimit {
                let lastRow = self.stackView.arrangedSubviews.last!
                stackView.removeArrangedSubview(lastRow)
                
                stackView.setNeedsLayout()
                stackView.layoutIfNeeded()
                
                lastRow.removeFromSuperview()
            }
            
            stackView.insertArrangedSubview(self.createLabel(text: newToDo.title), at: 0)
            stackView.setNeedsLayout()
//            stackView.addArrangedSubview(self.createLabel(text: newToDo.title))
            
            loadViewIfNeeded()
        }
    }
}
