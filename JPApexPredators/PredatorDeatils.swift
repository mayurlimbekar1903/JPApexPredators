//
//  PredatorDeatils.swift
//  JPApexPredators
//
//  Created by Mayur Limbekar on 20/08/25.
//

import SwiftUI
import MapKit

struct PredatorDeatils: View {
    let predator: ApexPredator
    @State var cameraPosition:MapCameraPosition
    @Namespace var namesapce
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    // BG image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.1), Gradient.Stop(color: .black, location: 1)], startPoint: .top, endPoint: .bottom)
                        }
                    
                    // dino image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width/1.5, height: geometry.size.height/3.7)
                        .scaleEffect(x:-1)
                        .shadow(color: .black, radius: 20)
                        .offset(y:20)
                        
                }
              
                VStack(alignment: .leading) {
                    // dino name
                    Text(predator.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    // Current locations
                    NavigationLink {
                        PredatorMap(cameraPosition: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000, heading: 250, pitch: 80)))
                            .navigationTransition(.zoom(sourceID: 1, in: namesapce))
                    } label: {
                        Map(position: $cameraPosition) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                        }
                        .frame(height: 125)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan.circle")
                                .font(.title)
                                .padding(.trailing)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current location")
                                .font(.caption)
                                .padding(.horizontal, 5)
                                .background(Color.gray.opacity(0.5))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }.matchedTransitionSource(id: 1, in: namesapce)
                    
                    // Appears in
                    Text("Appears in")
                        .font(.title3)
                        .padding(.top)
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("• " + movie)
                            .font(.subheadline)
                    }
                    // movie moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scence in
                        Text(scence.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scence.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    // link to webpage
                    Text("Read more...")
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }.padding()
                .frame(width: geometry.size.width,alignment: .leading)

            }.padding(.bottom, 20)
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let predator = Predators().allApexPredators[2]
    let cameraPosition = MapCameraPosition.camera(MapCamera.init(centerCoordinate: predator.location, distance: 30000))
    NavigationStack {
        PredatorDeatils(predator: predator, cameraPosition: cameraPosition)
            .preferredColorScheme(.dark)
    }
}
