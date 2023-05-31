//
//  SearchTableViewCell.swift
//  Gamer Hub
//
//  Created by Halil Oğuz on 29.05.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SearchTableViewCell"
    
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchGameNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(name: String, url: String?) {
        
        searchGameNameLabel.text = name.capitalized
        fetchImage(url: url ?? "")
        
        searchImageView.layer.cornerRadius = 8
    }
    
    func fetchImage(url: String) {
        
        let imageUrl = URL(string: url)
        
        DispatchQueue.main.async {
            self.searchImageView.kf.setImage(with: imageUrl)
        }
    }
}
