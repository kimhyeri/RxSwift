//
//  ViewController.swift
//  NewsMVVM
//
//  Created by hyeri kim on 11/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let baseURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=43f3fffb0a0f425e9cb5836dc9ac290f"
    private let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupTableView()
        setupNavigation()
        populateNews()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func populateNews() {
        guard let urlString = URL(string: baseURL) else {
            return
        }
        
        let resource = Resource<ArticleResponse>(url: urlString)
        URLRequest.load(resource: resource)
            .subscribe(onNext: { articleResponse in 
                let articles = articleResponse.articles
                self.articleListVM = ArticleListViewModel(articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let article = articleListVM else { return 0 }
        return article.articleVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.cellReusable, for: indexPath) as? ArticleTableViewCell else { return UITableViewCell() }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        return cell
        
    }
}
