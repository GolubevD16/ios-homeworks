//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.11.2021.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private let photos = PhotosData.getPhotos()
    private var images: [UIImage] = []
    private var userImages: [UIImage] = []
    private let imagePublisherFacade = ImagePublisherFacade()
    private let imageProcessor = ImageProcessor()

    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.toAutoLayout()
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUserImages()
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.imagePublisherFacade.removeSubscription(for: self)
        imagePublisherFacade.rechargeImageLibrary()
    }
    
    private func setupLayout(){
        view.addSubview(collectionView)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: .colId)
        collectionView.dataSource = self
        collectionView.delegate = self
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}


extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .colId, for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
        
        let img = images[indexPath.row]
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
            self.images.append($0)
        }
        collectionView.reloadData()
    }
}


extension String {
    static var colId = "photoCollectionViewCellReuseID"
}

extension PhotosViewController {
    
    /// Результаты измерения c фильтром tonal:
    /// Время выполнения с qos: default = 6812.0 miliseconds
    /// Время выполнения с qos: background = 57266.0 miliseconds
    /// Время выполнения с qos: userInitiated = 6048.0 miliseconds
    /// Время выполнения с qos: utility = 12829.0 miliseconds
    /// Время выполнения с qos: userInteractive = 5979.0 miliseconds
    
    private func initUserImages() {
        var sourceImages: [UIImage] = photos.compactMap { photo in UIImage(named: photo.name) }
        PhotosData.getPhotosMedia().forEach {
            sourceImages.append($0)
        }
        
        let start = DispatchTime.now()
        imageProcessor.processImagesOnThread(
            sourceImages: sourceImages,
            filter: .tonal,
            qos: .userInteractive,
            completion: { cgImages in
                self.userImages = cgImages.compactMap({ cgImage in
                    guard let cgImage = cgImage else { fatalError("Unable to fetch filter image") }
                    return UIImage(cgImage: cgImage)
                })
                let end = DispatchTime.now()
                let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
                let elapsedTime = Double(nanoTime / 1_000_000)
                print("Время выполнения \(elapsedTime) miliseconds")
                
                DispatchQueue.main.async {
                    self.imagePublisherFacade.subscribe(self)
                    self.imagePublisherFacade.addImagesWithTimer(
                        time: 0.25,
                        repeat: 10,
                        userImages: self.userImages
                    )
                }
            }
        )
    }
}
