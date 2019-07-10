//
//  ViewController.swift
//  NewsMVVM
//
//  Created by hyeri kim on 11/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        setupTableView()
        setupNavigation()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        
    }
    
    
}
