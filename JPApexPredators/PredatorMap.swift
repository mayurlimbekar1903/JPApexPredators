//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Mayur Limbekar on 20/08/25.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    @State var cameraPosition: MapCameraPosition
    let predators = Predators()
    
    @State var satellite: Bool = false
    
    var body: some View {
        
        Map(position: $cameraPosition) {
            ForEach(predators.allApexPredators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white,radius: 15)
                        .scaleEffect(x: -1)
                }
            }
        }.mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
            .overlay(alignment: .bottomTrailing, content:
                        {
                Button {
                    satellite.toggle()
                } label: {
                    Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                        .resizable()
                        .frame(width: 30, height: 30)
                }.padding([.trailing,.bottom],15)
            })
            .toolbarBackground(.automatic)
    }
}

#Preview {
    let predator = Predators().allApexPredators[2]
    let cameraPosition = MapCameraPosition.camera(MapCamera.init(centerCoordinate: predator.location, distance: 1000, heading: 250, pitch: 80))
    
    PredatorMap(cameraPosition: cameraPosition)
}
