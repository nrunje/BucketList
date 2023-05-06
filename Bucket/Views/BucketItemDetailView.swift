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
    @State private var searchText: String = ""
    @State private var base64Image: String = ""
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }
    
    func convertDateFormat(_ dateString: String) -> String {
        let endIndex = dateString.index(dateString.endIndex, offsetBy: -4)
        let firstPart = String(dateString[..<endIndex])
        let yearLastTwoDigits = String(dateString.suffix(2))
        let shortenedDateString = firstPart + yearLastTwoDigits
        return shortenedDateString
    }
    
    func addImageFormatPrefix(base64Image: String) -> String {
        let sanitizedBase64Image = base64Image.replacingOccurrences(of: "\n", with: "")
        
        if sanitizedBase64Image.hasPrefix("/9j/") {
            return "data:image/jpeg;base64," + sanitizedBase64Image
        } else if sanitizedBase64Image.hasPrefix("iVBORw0K") {
            return "data:image/png;base64," + sanitizedBase64Image
        } else {
            return sanitizedBase64Image // fallback, might want to handle this case differently
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                RemoteImageCreate(urlString: item.photo.base_url, base64Image: $base64Image)
//                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .clipped()

                Text(item.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()
                
                Text("Added by: \(item.user)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading, 15)
                    .padding(.top, -15)
                
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
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                
                Text("Personal notes:")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .padding(.leading)
                
                Text(item.note)
                    .padding([.leading, .horizontal])
                
//                Group {
//                    Button(action: {
//                        let formattedDate: String = convertDateFormat(item.date)
//                        print(item.date)
//                        print(formattedDate) // Output will be in "MM/dd/yyyy" format
//
//                        let currBucket = BucketItem(id: 0, user: "placeholder", name: item.name, location: item.location, likes: 0, date: formattedDate, note: item.note, photo: Photo(id: 0, base_url: "", created_at: "", item_id: 0), is_experience: item.is_experience)
//                        let currToken = NetworkManager.session_token
//
//                        let selectedImage = base64Image
//
//                        let fullSelectedImage = addImageFormatPrefix(base64Image: selectedImage)
//
//                        print("About to start networking requestion. ")
//                        print("Base64 image is:")
//                        print(fullSelectedImage)
//                        NetworkManager.shared.createItemScratch(item: currBucket, session_token: currToken) { response in
//                            DispatchQueue.main.async {
//                                print("Created item within create view")
//                            }
//                        }
//
//                        }
//                    ) {
//                        Text("Add to My BucketList")
//                            .foregroundColor(.white)
//                            .font(.headline)
//                            .padding(.vertical, 12)
//                            .padding(.horizontal, 24)
//                            .background(Color.blue)
//                            .cornerRadius(8)
//                    }
//                }
//                .frame(width: UIScreen.main.bounds.width)
//                .padding(.top, 20)
////                .background(Color.red)
                
            }
            .padding([.bottom], 200)
        }
        .padding(.zero) // set padding to zero to remove any spacing around the ScrollView
        .edgesIgnoringSafeArea(.top) // ignore top safe area
        .onAppear {
            searchText = item.location
        }
    }
}

struct RemoteImageCreate: View {
    let urlString: String
    @Binding var base64Image: String
    
    var body: some View {
        Group {
            if let url = URL(string: urlString), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .onAppear {
                        base64Image = uiImage.pngData()?.base64EncodedString() ?? ""
                    }
            } else {
                Image(systemName: "photo") // fallback image
                    .resizable()
            }
        }
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
