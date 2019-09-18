//
//  SearchViewController.swift
//  podcastReview
//
//  Created by C4Q on 9/18/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var podcastTableView: UITableView!
    
    var podcasts = [Podcast]() {
        didSet {
            podcastTableView.reloadData()
        }
    }
    
    var searchString: String? = nil {
        didSet {
            podcastTableView.reloadData()
            loadPodcastsFromSearch()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        podcastTableView.dataSource = self
        podcastTableView.delegate = self
        searchBar.delegate = self
    
    }
    
    
    private func loadPodcastsFromSearch() {
        if let searchString = searchString {
            PodcastAPIManager.shared.getPodcasts(searchWord: searchString) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let podcastsFromOnline):
                        self.podcasts = podcastsFromOnline
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    
    

}
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = podcastTableView.dequeueReusableCell(withIdentifier: "PodcastCell", for: indexPath) as! PodcastCell
        let podcast = podcasts[indexPath.row]
        cell.collectionLabel.text = podcast.collectionName
        cell.artistLabel.text = podcast.artistName
        
        ImageHelper.shared.getImage(urlStr: podcast.artworkUrl60) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    cell.podcastImage.image = imageFromOnline
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = searchText
        
    }
}

