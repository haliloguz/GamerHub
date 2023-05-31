//
//  GamesIconCollectionViewCell.swift
//  Gamer Hub
//
//  Created by Halil Oğuz on 25.05.2023.
//

import UIKit
import Kingfisher


class GamesIconCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GamesIconCollectionViewCell"
    var urlSession = URLSession(configuration: .default)
    
    @IBOutlet weak var GamesIconImageView: UIImageView!
    @IBOutlet weak var GamesIconNameLabel: UILabel!
    @IBOutlet weak var metaScoreLabel: UILabel!
    @IBOutlet weak var relasedLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var playTimeLabel: UILabel!
    
    var genreKK = "Genres: "
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func configure(name: String, url: String?, score: Int, relasedDate: String, genres: [GameGenres], playTime: Int){
        for genre in genres {
            
            if (genres.last == genre) {
                genreKK += "\(genre.name ?? "") "
                
                genresLabel.text = genreKK
                
            } else { genreKK += "\(genre.name ?? ""), "
                genresLabel.text = genreKK
            }
        }
        
        GamesIconNameLabel.text = name.capitalized
        metaScoreLabel.text = "\(score)"
        switch score {
        case 80...100:
            metaScoreLabel.textColor = .green
        case 60...80:
            metaScoreLabel.textColor = .yellow
        case 0...60:
            metaScoreLabel.textColor = .red
        default:
            metaScoreLabel.textColor = .white
        }
        
        relasedLabel.text = "Relased Date: " + relasedDate
        playTimeLabel.text = "Playtime: \(playTime) Hours"
        fetchImage(url: url ?? "")
        
    }
    
    func fetchImage(url: String) {
        
        let imageUrl = URL(string: url)
        
        DispatchQueue.main.async {
            self.GamesIconImageView.kf.setImage(with: imageUrl)
        }
    }
}
