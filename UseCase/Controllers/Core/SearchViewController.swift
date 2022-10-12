//
//  SearchViewController.swift
//  UseCase
//
//  Created by Rodrigo Souza on 11/10/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles: [Movie] = [Movie]()

    private let discoveryTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or Tv sow"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discoveryTable)
        discoveryTable.delegate = self
        discoveryTable.dataSource = self
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        
        fetchDiscoveryMovies()
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoveryTable.frame = view.bounds
    }

    
    private func fetchDiscoveryMovies() {
        DispatchQueue.global(qos: .background).async {
            APICaller.shared.getDiscoveryMovies { [weak self] result in
                switch result {
                case .success(let titles):
                    DispatchQueue.main.async {
                        self?.titles = titles
                        self?.discoveryTable.reloadData()
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier,
                                                       for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }

        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "unknown", posterURL: title.poster_path ?? "")
        
        cell.configure(with: model)

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        DispatchQueue.global(qos: .background).async {
            APICaller.shared.getMovie(with: titleName + " trailer") { [weak self] result in
                switch result {
                case .success(let video):
                    DispatchQueue.main.async { [weak self] in
                        let vc = TitlePreviewViewController()
                        let viewModel = TitlePreviewViewModel(title: titleName, titleOverview: title.overview ?? "", youtubeView: video)
                        vc.configure(with: viewModel)
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
                !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
        let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        resultController.delegate = self
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.global(qos: .background).async {
                switch result {
                case .success(let titles):
                    DispatchQueue.main.async {
                        resultController.titles = titles
                        resultController.searchResultCollectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


