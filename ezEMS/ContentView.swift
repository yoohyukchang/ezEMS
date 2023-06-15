//
//  ContentView.swift
//  ezEMSApp
//
//  Created by Yoohyuk Chang on 6/15/23.
//

import SwiftUI
import SwiftyTesseract
import Combine

class ContentViewModel: ObservableObject {
    @Published var recognizedText: String = ""

    func recognizeText() {
        let tesseract = Tesseract(languages: [.english])
        guard let image = UIImage(named: "test_image") else {
            print("Image not found!")
            return
        }

        print(image)

        let publisher: AnyPublisher<String, Tesseract.Error> = tesseract.performOCRPublisher(on: image)

        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error: \(error)")
                    case .finished:
                        print("Finished recognizing text.")
                    }
                },
                receiveValue: { recognizedText in
                    self.recognizedText = recognizedText
                }
            )
            .store(in: &cancellables)
    }
    
    private var cancellables: Set<AnyCancellable> = []
}

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

