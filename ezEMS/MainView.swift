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

    var body: some View {
        VStack {
            
            ZStack(alignment: .bottomTrailing) {
                Button(action: {
                    openCameraRoll = true
                }, label:  {
                    Image("camera_icon")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                })
                Image(systemName: "plus")
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                    .background(Color.gray)
                    .clipShape(Circle())
                
            }.sheet(isPresented: $openCameraRoll) {
                ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
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

