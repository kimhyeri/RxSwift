//
//  AddTaskViewController.swift
//  ToDo
//
//  Created by hyeri kim on 01/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private let taskSubject = PublishSubject<Task>() 
    let disposeBag = DisposeBag()
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let priority = Priority(rawValue: self.segmentedControl.selectedSegmentIndex), let title = self.textField.text else { return }
        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
