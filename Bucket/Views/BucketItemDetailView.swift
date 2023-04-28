//
//  BucketItemDetailView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/28/23.
//

import SwiftUI
import MapKit

struct BucketItemDetailView: View {
    
    let item: BucketItem
    
    @State private var searchText: String = "Austin"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(photoPlaceholder)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)

                Text(item.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()
                
                HStack {
                    Text(item.location)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(item.date)
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
                
                Text(item.note)
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
        BucketItemDetailView(item: demoBucketItems[0])
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
