//
//  MainView.swift
//  ezEMSApp
//
//  Created by Yoohyuk Chang on 6/15/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()

    var body: some View {
        VStack {
            Text(viewModel.recognizedText)
            Button(action: viewModel.recognizeText) {
                Text("Test")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

