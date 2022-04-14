//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 04.04.2022.
//

import Foundation
import UIKit
import StorageService

final class ProfileViewModel {
    var onStateChanged: ((State) -> Void)?
    var photosTapped: (() -> Void)?
    var posts: [Post]!
    
    private(set) var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }
    
    private(set) var devices = [UIImage]()

    func send(_ action: Action) {
        switch action {
        case .viewIsReady:
            state = .loaded
            fetchDevices()
        case .showGallery:
            state = .gallaryTapped
        }
    }
    
    private func fetchDevices() {
        posts = PostModel.getPosts()
    }
}

extension ProfileViewModel {

    enum Action {
        case viewIsReady
        case showGallery
    }

    enum State {
        case initial
        case loaded
        case gallaryTapped
        case error(String)
    }
}
