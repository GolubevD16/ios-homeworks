//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.11.2021.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private var images: [UIImage] = PhotosData.getPhotos()
    private var photos: [UIImage] = []
    let facade = ImagePublisherFacade()
        
    deinit {
        facade.removeSubscription(for: self)
        facade.rechargeImageLibrary()
    }
    
    lazy var collectionView: UICollectionView = {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.toAutoLayout()
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
        setupLayout()
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: .colId)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        configureFacade()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.facade.removeSubscription(for: self)
        facade.rechargeImageLibrary()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureFacade(){
        receive(images: PhotosData.getPhotosMedia())
        self.facade.subscribe(self)
        self.facade.addImagesWithTimer(time: 1, repeat: 10, userImages: images)
    }
}


extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .colId, for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
        let img = photos[indexPath.row]
        cell.addPhoto(image: img)
        return cell
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemInRow: CGFloat = 3
        let totalSpacing: CGFloat = 40
        return CGFloat((width - totalSpacing) / itemInRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: UIScreen.main.bounds.width, spacing: 8)
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}


extension PhotosViewController: ImageLibrarySubscriber{
    func receive(images: [UIImage]) {
        images.forEach{
            photos.append($0)
        }
        collectionView.reloadData()
    }
}


extension String {
    static var colId = "photoCollectionViewCellReuseID"
}
