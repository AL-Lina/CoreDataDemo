//
//  TaskViewController.swift
//  CoreDataDemo
//
//  Created by Alina Sokolova on 26.01.22.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        createButton(withTitle: "Save",
                     andColor: UIColor(red: 21/255,
                                       green: 101/255,
                                       blue: 192/255,
                                       alpha: 194/255),
                     action: UIAction { _ in
            self.save()
        })
        
    }()
    
    private lazy var cancelButton: UIButton = {
      createButton(withTitle: "Cancel",
                   andColor: .systemRed,
                   action: UIAction { _ in
          self.dismiss(animated: true)
      })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUp(subwievs: taskTextField, saveButton, cancelButton)
        setUpConstraints()
    }
    
    private func setUp(subwievs: UIView...) {
        subwievs.forEach { subwiev in
            view.addSubview(subwiev)
        }
        }
    
    private func setUpConstraints() {
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
           cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
           cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func createButton(withTitle title: String, andColor color: UIColor, action: UIAction) -> UIButton {
        var button = UIButton.Configuration.filled()
        
       
        button.baseBackgroundColor = color
                                             
        
        var attributesConatiner = AttributeContainer()
        attributesConatiner.font = UIFont.boldSystemFont(ofSize: 18)
        button.attributedTitle = AttributedString(title, attributes: attributesConatiner)
        
        return UIButton(configuration: button, primaryAction: action)
        }
    
    private func save() {
        // Для сложных взаимосвязей в модели
//        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
//        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        
        //Для простой модели
        let task = Task(context: context)
        task.name = taskTextField.text
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        dismiss(animated: true)
    }
    }
    


