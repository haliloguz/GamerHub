//
//  MultiViewModel.swift
//  Gamer Hub
//
//  Created by Halil Oğuz on 25.05.2023.
//

import Foundation

struct GameResponse: Codable {
    let results: [Game]
    let next: String?
}
struct Game: Codable {
    let id: Int?
    let name: String?
    let released: String?
    let background_image: String?
    let rating: Double?
    let reviews_count: Int?
    let platforms: [GamePlatforms]?
    let genres: [GameGenres]?
    let metacritic: Int?
    let playtime: Int?
    
    init(id: Int? = nil,
         name: String? = nil,
         released: String? = nil,
         background_image: String? = nil,
         rating: Double? = nil,
         reviews_count: Int? = nil,
         platforms: [GamePlatforms]? = nil,
         genres: [GameGenres]? = nil,
         metacritic: Int? = nil,
         playtime: Int? = nil) {
        self.id = id
        self.name = name
        self.released = released
        self.background_image = background_image
        self.rating = rating
        self.reviews_count = reviews_count
        self.platforms = platforms
        self.genres = genres
        self.metacritic = metacritic
        self.playtime = playtime
    }
    
    var formattedDate: String {
        if let formattedDate = released?.components(separatedBy: ["-"]) {
            let year = formattedDate[0]
            let month = formattedDate[1]
            let day = formattedDate[2]
            
            switch month {
            case "01":
                return "\(day) January \(year)"
            case "02":
                return "\(day) February \(year)"
            case "03":
                return "\(day) March \(year)"
            case "04":
                return "\(day) April \(year)"
            case "05":
                return "\(day) May \(year)"
            case "06":
                return "\(day) June \(year)"
            case "07":
                return "\(day) July \(year)"
            case "08":
                return "\(day) August \(year)"
            case "09":
                return "\(day) September \(year)"
            case "10":
                return "\(day) October \(year)"
            case "11":
                return "\(day) November \(year)"
            case "12":
                return "\(day) December \(year)"
            default:
                return "TBA"
                
            }
        }
        
        return "TBA"
        
    }
    
}

struct GamePlatforms: Codable {
    let platform: GamePlatform?
}

struct GamePlatform: Codable {
    let name: String?
}

struct GameGenres: Codable, Equatable {
    let name: String?
}
