//
//  Predators.swift
//  JPApexPredators
//
//  Created by Mayur Limbekar on 19/08/25.
//

import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorsData()
    }
    
    func decodeApexPredatorsData() {
        
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("error description: \(error.localizedDescription)")
            }
        }
    }
    
    func searchTerm(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(with aplhabeticalOrder: Bool) {
        if aplhabeticalOrder {
            apexPredators.sort { apexPredator1, apexPredator2 in
                apexPredator1.name < apexPredator2.name
            }
        } else {
            apexPredators.sort { apexPredator1, apexPredator2 in
                apexPredator1.id < apexPredator2.id
            }
        }
    }
    
    func search(by type: APType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter({ $0.type == type })
        }
    }
}
