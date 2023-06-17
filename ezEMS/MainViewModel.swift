//
//  MainViewModel.swift
//  ezEMS
//
//  Created by Yoohyuk Chang on 6/15/23.
//

import SwiftUI
import SwiftyTesseract
import Combine

class MainViewModel: ObservableObject {
    @Published var recognizedText: String = ""

    func recognizeText(from image: UIImage) {
        let tesseract = Tesseract(languages: [.english])

        print(image) // can delete (just for checking if an image is properly selected.)

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
                    // *** additional code to handle the recognized text
                }
            )
            .store(in: &cancellables)
    }

    
    private var cancellables: Set<AnyCancellable> = []
}
