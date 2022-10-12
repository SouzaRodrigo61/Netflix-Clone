//
//  HomeViewController.swift
//  UseCase
//
//  Created by Rodrigo Souza on 11/10/22.
//

import UIKit


enum Section: Int {
    case TrendingMovie = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = [
        "Trending Movies",
        "Trending TV",
        "Popular",
        "Upcoming Movies",
        "Top rated"
    ]
    
    // MARK: - Views
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero,
                                style: .grouped)
        
        table.register(CollectionViewTableViewCell.self,
                       forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        return table
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeFeedTable.frame = view.bounds
    }
    

    
    
    // MARK: - Privates
    
    private func configureNavBar() {
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           style: .done,
                                                           target: self,
                                                           action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"),
                            style: .done,
                            target: self,
                            action: nil),
            
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"),
                            style: .done,
                            target: self,
                            action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Number of sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CollectionViewTableViewCell.identifier,
            for: indexPath) as? CollectionViewTableViewCell
        else {
            return UITableViewCell()
        }
        
        /// TODO: Segregate apicaller to other flow, It is bad
        switch indexPath.section {
        case Section.TrendingMovie.rawValue:
            DispatchQueue.global().async {
                APICaller.shared.getTrendingMovie { result in
                    switch result {
                    case.success(let movie):
                        DispatchQueue.main.async {
                            cell.configure(with: movie)
                        }
                    case .failure(let error):
                        DispatchQueue.main.sync {
                            print(error)
                        }
                    }
                }
            }
            
        case Section.TrendingTv.rawValue:
            DispatchQueue.global().async {
                APICaller.shared.getTrendingMovie { result in
                    switch result {
                    case.success(let movie):
                        DispatchQueue.main.async {
                            cell.configure(with: movie)
                        }
                    case .failure(let error):
                        DispatchQueue.main.sync {
                            print(error)
                        }
                    }
                }
            }
            
        case Section.Popular.rawValue:
            DispatchQueue.global().async {
                APICaller.shared.getPopularMovie { result in
                    switch result {
                    case.success(let movie):
                        DispatchQueue.main.async {
                            cell.configure(with: movie)
                        }
                    case .failure(let error):
                        DispatchQueue.main.sync {
                            print(error)
                        }
                    }
                }
            }
            
        case Section.Upcoming.rawValue:
            DispatchQueue.global().async {
                APICaller.shared.getUpcomingMovie { result in
                    switch result {
                    case.success(let movie):
                        DispatchQueue.main.async {
                            cell.configure(with: movie)
                        }
                    case .failure(let error):
                        DispatchQueue.main.sync {
                            print(error)
                        }
                    }
                }
            }
            
        case Section.TopRated.rawValue:
            DispatchQueue.global().async {
                APICaller.shared.getTopRated { result in
                    switch result {
                    case.success(let movie):
                        DispatchQueue.main.async {
                            cell.configure(with: movie)
                        }
                    case .failure(let error):
                        DispatchQueue.main.sync {
                            print(error)
                        }
                    }
                }
            }
            
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y,
                                         width: 100,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
    }
    
    // MARK: ScrollView
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        // When scroll to bottom, navigation controller bar is hiden.
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
