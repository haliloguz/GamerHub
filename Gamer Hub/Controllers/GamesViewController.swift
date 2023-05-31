//
//  GamesViewController.swift
//  Gamer Hub
//
//  Created by Halil Oğuz on 24.05.2023.
//

import Foundation
import UIKit

class GamesViewController: UIViewController {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var searchTableView = UITableView()
    let urlSession = URLSession(configuration: .default)
    var response: GameResponse? {
        didSet {
            DispatchQueue.main.async {
                if let result = self.response?.results{
                    self.allGames.append(contentsOf: result)
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var searchResponse: GallerySearchModel? {
        didSet {
            DispatchQueue.main.async {
                if let result = self.searchResponse?.results{
                    self.searchResults = result
                    self.searchTableView.reloadData()
                }
            }
        }
    }
    
    var allGames: [Game] = []
    var searchResults: [Search] = []
    var searchingKey = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.delegate = self
        collectionViewSetup()
        fetch()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func collectionViewSetup() {
        
        view.addSubview(collectionView)
        collectionView.register(UINib.loadNib(name: GamesIconCollectionViewCell.reuseIdentifier), forCellWithReuseIdentifier: GamesIconCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
    }
    
    func searchTableViewSetup() {
        view.addSubview(searchTableView)
        searchTableView.register(UINib.loadNib(name: SearchTableViewCell.reuseIdentifier), forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)])
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.backgroundColor = .white
        
    }
    
    func fetch(){
        
        let url = URL(string: Constants.gamesUrl)
        urlSession.request(url: url, model: GameResponse.self) {response in
            switch response {
            case .success(let model):
                self.response = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchSearchResults(query: String) {
        let url = URL(string: Constants.searchUrl + query + Constants.keyUrl)
        urlSession.request(url: url, model: GallerySearchModel.self) { response in
            switch response {
            case .success(let model):
                self.searchResponse = model
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension GamesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(), animated: true)
    }
}

extension GamesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
        
        cell.configure(name: searchResults[indexPath.row].name ?? "", url: searchResults[indexPath.row].background_image)
        cell.layer.cornerRadius = 8
        
        return cell
    }
}


extension GamesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesIconCollectionViewCell.reuseIdentifier, for: indexPath) as! GamesIconCollectionViewCell
        if let genres = allGames[indexPath.row].genres {
            cell.configure(name: allGames[indexPath.row].name ?? "" , url: allGames[indexPath.row].background_image, score: allGames[indexPath.row].metacritic ?? 0, relasedDate: allGames[indexPath.row].formattedDate , genres: genres, playTime: allGames[indexPath.row].playtime ?? 0)
        }
        
        cell.layer.cornerRadius = 15
        cell.backgroundColor = .gray.withAlphaComponent(0.7)
        
        return cell
    }
}

extension GamesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if allGames.count - 6 == indexPath.row {
            let url = URL(string: response?.next ?? "")
            urlSession.request(url: url, model: GameResponse.self) { response in
                switch response {
                case .success(let model):
                    self.response = model
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc = DetailViewController()
        detailVc.game = allGames[indexPath.item]
        navigationController?.pushViewController(detailVc, animated: true)
    }
    
    
}

extension GamesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width)-10, height: (view.frame.size.width)-10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)
    }
}

extension GamesViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            collectionViewSetup()
        } else {
            collectionView.removeFromSuperview()
            searchTableViewSetup()
            
            if searchText.count > 2 {
                fetchSearchResults(query: searchText)
            }
        }
    }
    
}
