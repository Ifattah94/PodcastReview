//
//  PodcastDetailViewController.swift
//  podcastReview
//
//  Created by C4Q on 9/18/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class PodcastDetailViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var podcastImageView: UIImageView!
    
    var podcast: Podcast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPodcastDetails()

        // Do any additional setup after loading the view.
    }
    
    
    private func setupPodcastDetails() {
        nameLabel.text = podcast.artistName
        
        ImageHelper.shared.getImage(urlStr: podcast.artworkUrl100) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageFromOnline):
                    self.podcastImageView.image = imageFromOnline
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }

  

}
