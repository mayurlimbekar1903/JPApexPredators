//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Mayur Limbekar on 19/08/25.
//

import SwiftUI
import MapKit
struct ContentView: View {
    let predators = Predators()
    @State var searchText: String = ""
    @State var alphabeticalOrder:Bool = false
    @State var currentSelection:APType = APType.all
    
    var filteredPredators: [ApexPredator] {
        predators.search(by: currentSelection)
        predators.sort(with: alphabeticalOrder)
        return predators.searchTerm(for: searchText)
    }
    var body: some View {
        NavigationStack {
            List(filteredPredators) { predator in
                NavigationLink {
                    PredatorDeatils(predator: predator, cameraPosition: MapCameraPosition.camera(MapCamera(centerCoordinate: predator.location, distance: 3000)))
                } label: {
                    HStack {
                        // dinasour image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        //VStack
                        VStack(alignment: .leading) {
                            // name
                            Text(predator.name)
                                .fontWeight(.bold)
                            // type
                            Text(predator.type.rawValue.capitalized)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(predator.type.backgroundColor)
                                .clipShape(.capsule)
                        }
                    }
                }
            }.navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabeticalOrder.toggle()
                        }
                    } label: {
                        Image(systemName: alphabeticalOrder ? "film" : "textformat")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("filter", selection: $currentSelection.animation()) {
                            ForEach(APType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
