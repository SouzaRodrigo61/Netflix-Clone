//
//  TitlePreviewViewController.swift
//  UseCase
//
//  Created by Rodrigo Souza on 12/10/22.
//

import UIKit
import WebKit


class TitlePreviewViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lord of the rings"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lord of the rings sdasadsadas asdas das das das das das asd das das das das dsa das sadsadas as d"
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds =  true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(overviewLabel)
        view.addSubview(titleLabel)
        view.addSubview(downloadButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let webViewContraints = [
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250),
        ]
        
        let titleLabelContraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        
        let overviewLabelContraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downloadButtonContraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        NSLayoutConstraint.activate(webViewContraints)
        NSLayoutConstraint.activate(titleLabelContraints)
        NSLayoutConstraint.activate(overviewLabelContraints)
        NSLayoutConstraint.activate(downloadButtonContraints)
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.webView.load(URLRequest(url: url))
            
        }
    }
}
