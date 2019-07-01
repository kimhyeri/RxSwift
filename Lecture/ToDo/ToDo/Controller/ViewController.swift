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
        setupNavigation()
    }   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController, 
            let addTVC = navC.viewControllers.first as? AddTaskViewController else {
                return
        }
        
        addTVC.taskSubjectObservable
            .subscribe(onNext: { [weak self] task in 
                guard let self = self else { return }
                let segmentIndex = self.prioritySegmentedControl.selectedSegmentIndex - 1
                let priority = Priority(rawValue: segmentIndex)
                
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                self.tasks.accept(existingTasks)
                
                self.filterTasks(by: priority)
            }).disposed(by: disposeBag)
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
            self.tableView.reloadData()
        } else {
            self.tasks.map { tasks in 
                return tasks.filter({ $0.priority == priority! })
                }.subscribe(onNext: { [weak self](tasks) in
                    self?.filteredTasks = tasks
                    self?.tableView.reloadData()
                }).disposed(by: disposeBag)
        }
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseIdentifier, for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = filteredTasks[indexPath.row].title
        return cell
    }
}
