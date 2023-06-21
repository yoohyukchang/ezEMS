//
//  MainView.swift
//  ezEMSApp
//
//  Created by Yoohyuk Chang on 6/15/23.
//

// *** Please make sure to handle the case when no image is selected and the 'ANALAYZE' button is clicked. In the current implementation, this situation would lead to a blank image being sent to the Tesseract engine, which could lead to unexpected results. Add an error handling mechanism to prevent this.

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State var changeImage = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    @State var openCamera = false

    var body: some View {
        VStack {
            HStack() {
                Button(action: {
                    openCameraRoll = true
                }, label:  {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 120, height: 120)
                        
                        Image("access_album")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                })
//                Image(systemName: "plus")
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(.black)
//                    .background(Color.gray)
//                    .clipShape(Circle())
                Button(action: {
                    openCamera = true
                }, label: {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 120, height: 120)
                        
                        Image("access_camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                })
            }.sheet(isPresented: $openCameraRoll) {
                ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
            }
            .sheet(isPresented: $openCamera) {
                ImagePicker(selectedImage: $imageSelected, sourceType: .camera)
            }
            
            Text(viewModel.recognizedText)
            Button(action: {
                viewModel.recognizeText(from: imageSelected)
            }) {
                Text("ANALYZE")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

