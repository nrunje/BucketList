//
//  CreateItemView.swift
//  Bucket
//
//  Created by Nicholas Runje on 5/5/23.
//

import SwiftUI

struct CreateItemView: View {
    @State private var name: String = ""
    @State private var location: String = ""
    @State private var date: String = ""
    @State private var note: String = ""
    @State private var photo: String = ""
    @State private var is_experience: Bool = false
    @State private var isShowingImagePicker = false
    @State private var selectedImage = ""
    
    @Binding var isShowingView: Bool
    @State private var selectedDate = Date()
    @State private var thumbnail: UIImage? = nil

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }
    
    var body: some View {
        ScrollView {
            Group {
                VStack(alignment: .center, spacing: 16) {
                    Text("Create Item")
                            .font(.title2)
                            .fontWeight(.bold)
                    
                    VStack(alignment: .center, spacing: 16) {

                        Button(action: {
                            isShowingImagePicker = true
                        }, label: {
                            Text("Select Photo")
                        })
                        .sheet(isPresented: $isShowingImagePicker) {
                            ImagePicker(isPresented: $isShowingImagePicker, selectedImage: $selectedImage)
                                .onChange(of: selectedImage) { newValue in
                                    if let data = Data(base64Encoded: newValue.replacingOccurrences(of: "data:image/png;base64,", with: "")),
                                       let uiImage = UIImage(data: data) {
                                        thumbnail = uiImage
                                    }
                                }
                        }

                        if let thumbnail = thumbnail {
                            Image(uiImage: thumbnail)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(5)
                        }

                        // ... Rest of your code

                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .center, spacing: 16) {
                        
                        TextField("Enter activity name", text: $name)
                            .foregroundColor(.secondary)
                            .autocapitalization(.none)
                            .textCase(.lowercase)
                        
                        TextField("Enter location", text: $location)
                            .foregroundColor(.secondary)
                            .autocapitalization(.none)
                            .textCase(.lowercase)
                        
                        VStack {
                            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .padding()
                            
                            Text("Selected date: \(selectedDate, formatter: dateFormatter)")
                                .padding()
                            
                        }
                        
                        TextField("Enter personal note", text: $note)
                            .foregroundColor(.secondary)
                            .autocapitalization(.none)
                            .textCase(.lowercase)
                        
                        Toggle("Is Experience?", isOn: $is_experience)
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                        Button {
                            // to do
                            let formattedDate = dateFormatter.string(from: selectedDate)
                            print(formattedDate) // Output will be in "MM/dd/yyyy" format
                            
                            let currBucket = BucketItem(id: 0, user: "placeholder", name: name, location: location, likes: 0, date: formattedDate, note: note, photo: Photo(id: 0, base_url: "", created_at: "", item_id: 0), is_experience: is_experience)
                            let currToken = NetworkManager.session_token
                            
                            NetworkManager.shared.createItemScratch(item: currBucket, session_token: currToken, photo: selectedImage) { response in
                                DispatchQueue.main.async {
                                    print("Created item within create view")
                                    isShowingView = false
                                }
                            }
                            
//                            print("Selected image is below:")
//                            print(selectedImage)
                        } label: {
                            Text("Create")
                                .padding(.top, 8)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            
            Spacer()
        }
    }
}

struct CreateItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreateItemView(isShowingView: .constant(true))
    }
}

