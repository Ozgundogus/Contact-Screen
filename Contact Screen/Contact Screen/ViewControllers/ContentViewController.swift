//
//  ContentViewController.swift
//  Contact Screen
//
//  Created by Ozgun Dogus on 10.02.2024.
//

import UIKit

class ContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        return tableView
    }()
    
    
    private var articles = [Article]()
    
    
    private var activityIndicator: UIActivityIndicatorView = {
           let indicator = UIActivityIndicatorView(style: .large)
           indicator.translatesAutoresizingMaskIntoConstraints = false
           indicator.hidesWhenStopped = true
            indicator.color = .black
           return indicator
       }()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupActivityIndicator()
        fetchNews()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupActivityIndicator() {
           view.addSubview(activityIndicator)
           
           NSLayoutConstraint.activate([
               activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
           ])
        
           activityIndicator.startAnimating()
       }
    
    private func fetchNews() {
           NewsService().fetchTopHeadlines { [weak self] result in
               DispatchQueue.main.async {
                   self?.activityIndicator.stopAnimating()
               }
               
               switch result {
               case .success(let welcome):
                   self?.articles = welcome.articles
                   DispatchQueue.main.async {
                       self?.tableView.reloadData()
                   }
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? ContentTableViewCell else {
               return UITableViewCell()
           }
           
           
        let article = articles[indexPath.row]
               cell.configure(with: article)
               return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

