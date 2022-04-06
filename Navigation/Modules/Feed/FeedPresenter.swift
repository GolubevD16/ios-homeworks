//
//  FeedPresenter.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 30.03.2022.
//

import Foundation

protocol FeedPresenterInput: AnyObject{
    var feedView: FeedView {get set}
    var buttonPressed: (() -> Void)? {get set}
}

protocol FeedPresenterOutput: AnyObject{
    var buttonPressed: (() -> Void)? { get set }
}

protocol NextVC{
    func nextVC() -> ()
    func checkWord(word: String) -> ()
}

final class FeedPresenter: FeedPresenterOutput{
    weak var input: FeedPresenterInput?
    let feedView: FeedView

    var model: Model?
    var buttonPressed: (() -> Void)?
    
    init() {
        feedView = FeedView()
        feedView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(checkPassword), name: .checkPassword, object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func checkPassword(notification: Notification){
        guard let isCorrect = notification.object as? Bool else { return }
        isCorrect ? input?.feedView.animateGreen() : input?.feedView.animateRed()
    }
}

extension FeedPresenter: NextVC{
    func checkWord(word: String) {
        model = Model()
        model?.check(word: word)
    }
    
    func nextVC() {
        buttonPressed?()
    }
}
