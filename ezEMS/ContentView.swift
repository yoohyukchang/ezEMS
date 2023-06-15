//
//  ContentView.swift
//  ezEMSApp
//
//  Created by Yoohyuk Chang on 6/15/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Text(viewModel.recognizedText)
            Button(action: viewModel.recognizeText) {
                Text("Test")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

