//
//  UpcomingViewController.swift
//  UseCase
//
//  Created by Rodrigo Souza on 11/10/22.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var titles: [Movie] = [Movie]()
    
    private let upcomingTable: UITableView = {
        let table = UITableView()
        
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcoming()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upcomingTable.frame = view.bounds
    }
    
    
    private func fetchUpcoming() {
        DispatchQueue.global().async {
            APICaller.shared.getUpcomingMovie { [weak self] result in
                switch result {
                case .success(let titles):
                    DispatchQueue.main.async {
                        self?.titles = titles
                        self?.upcomingTable.reloadData()
                    }
                case .failure(let error):
                    DispatchQueue.main.sync {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier,
                                                       for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(
            titleName: (title.original_title ?? title.original_name) ?? "unknown",
            posterURL: title.poster_path ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
