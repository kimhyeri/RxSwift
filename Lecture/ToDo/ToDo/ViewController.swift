//
//  ViewController.swift
//  ToDo
//
//  Created by hyeri kim on 30/06/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }   
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.title = "ToDo List"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController, 
            let addTVC = navC.viewControllers.first as? AddTaskViewController else {
                return
        }
        
        addTVC.taskSubjectObservable
            .subscribe(onNext: { [weak self] task in 
                guard let self = self else { return }
                let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
                
                
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                self.tasks.accept(existingTasks)
                
                self.filterTasks(by: priority)
            }).disposed(by: disposeBag)
    }
    
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
        } else {
            self.tasks.map { tasks in 
                return tasks.filter({ $0.priority == priority! })
                }.subscribe(onNext: { [weak self](tasks) in
                    self?.filteredTasks = tasks
                }).disposed(by: disposeBag)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
