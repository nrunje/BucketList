//
//  BucketItemDetailView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/28/23.
//

import SwiftUI
import MapKit

struct BucketItemDetailView: View {
    @State private var searchText: String = "Austin"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(photoPlaceholder)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)

                Text("Sample activity")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()
                
                HStack {
                    Text("Austin, Texas")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text("July 4th, 2023")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
               // Import map
                MapView(searchText: $searchText)
                    .frame(width: 300, height: 300)
                
                Text("Personal notes:")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .padding(.leading)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .padding([.leading, .horizontal])
            }
            .padding([.bottom], 200)
        }
        .padding(.zero) // set padding to zero to remove any spacing around the ScrollView
        .edgesIgnoringSafeArea(.top) // ignore top safe area
    }
}

struct BucketItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BucketItemDetailView()
    }
}


struct MapView: UIViewRepresentable {
    @Binding var searchText: String
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            let mapRegion = MKCoordinateRegion(center: response.mapItems[0].placemark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            mapView.setRegion(mapRegion, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = response.mapItems[0].placemark.coordinate
            annotation.title = response.mapItems[0].name
            mapView.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "customView")
        annotationView.canShowCallout = true
        return annotationView
    }
}
