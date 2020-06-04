//
//  FetchPhotoOperation.swift
//  Astronomy
//
//  Created by Joe Veverka on 6/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class FetchPhotoOperation: ConcurrentOperation {

    //MARK: -Properties

    var photoReference: MarsPhotoReference
    var imageData: Data?

    init(photoReference: MarsPhotoReference) {
        self.photoReference = photoReference
    }

    //MARK: -Overrides

    override func start() {
        state = .isExecuting

        guard let imageURL = photoReference.imageURL.usingHTTPS else { return }

        fetchPhoto = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            defer { self.state = .isFinished }

            if let error = error {
                NSLog("Error fetching photos: \(error)")
                return
            }

            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                NSLog("Invalid response: \(response)")
                return
            }

            guard let data = data else { return }
            self.imageData = data
        }
        fetchPhoto?.resume()
    }

    override func cancel() {
        fetchPhoto?.cancel()
    }

    //MARK: -Private
    private var fetchPhoto: URLSessionDataTask?
}
