//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Mayur Limbekar on 19/08/25.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScenes]
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case latitude
        case longitude
        case movies
        case movieScenes = "movie_scenes"
        case link
    }
        
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var image:String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    struct MovieScenes: Decodable , Identifiable{
        let id: Int
        let movie: String
        let sceneDescription: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case movie
            case sceneDescription = "scene_description"
        }
    }
}

enum APType: String, Decodable , CaseIterable, Identifiable {
    case all
    case land
    case air
    case sea
    
    var id: APType {
        self
    }
    var backgroundColor: Color {
        switch self {
        case .land:
            return .brown
        case .air:
            return .teal
        case .sea:
            return .blue
        case .all:
            return .gray
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind.snow"
        case .sea:
            "drop.halffull"
        }
    }
}
